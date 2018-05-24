//
//  ShoppingCartViewController.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "TabBarViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCarEntity.h"
#import "StoreEntity.h"
#import "SupplierCommodityEndity.h"
#import "ShoppingHandler.h"
#import "ShoppingBottomView.h"
#import "PurchaseHandler.h"
#import "AddressEntity.h"
#import "ShoppingInvalidTableViewCell.h"
#import "ConfirmOrderViewController.h"
#import "SupplierShopViewController.h"
#import "PurchaseTabBarViewController.h"

@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic,strong)BaseTableView     *tb_shoppingCart;
@property (nonatomic,strong)NSMutableArray    *arr_data;
@property (nonatomic,strong)ShoppingCarEntity *shoppingCarEntity;
@property (nonatomic,strong)NSMutableArray    *arr_select;
@property (nonatomic,strong)ShoppingBottomView  *v_bottomNormal;
@property (nonatomic,assign)int                 editStatus;
@property (nonatomic,strong)UIBarButtonItem   *btn_right;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    self.arr_data = [NSMutableArray array];
    self.arr_select = [NSMutableArray array];
    
    self.btn_right = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editAction)];
    self.navigationItem.rightBarButtonItem = self.btn_right;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadShoppingCount];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NocatifionPayCompleteAndRefreshDataAction) name:@"PayCompleteAndRefreshData" object:nil];
    [self.tb_shoppingCart loadDataNoRefreshing];
}

- (void)loadShoppingCount{
    [ShoppingHandler getCountInShopCartprepare:^{
    } success:^(id obj) {
        if ([obj intValue] > 0) {
            [(PurchaseTabBarViewController *)self.tabBarController showBadgeOnItemIndex:1 withCount:[obj intValue]];
        }
    } failed:^(NSInteger statusCode, id json) {
    }];
}

- (void)onCreate{
    
    self.tb_shoppingCart = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 49 - 46) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
    self.tb_shoppingCart.delegate = self;
    self.tb_shoppingCart.dataSource = self;
    self.tb_shoppingCart.tableViewDelegate = self;
    self.tb_shoppingCart.tableFooterView = [UIView new];
    self.tb_shoppingCart.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_shoppingCart];
    
    self.v_bottomNormal = [[ShoppingBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight - 49 - 46, SCREEN_WIDTH, 46)];
    [self.v_bottomNormal.btn_checkout setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
    [self.v_bottomNormal.btn_checkout setEnabled:NO];
    [self.v_bottomNormal.btn_selectAll addTarget:self action:@selector(selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_bottomNormal.btn_checkout addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.v_bottomNormal];
    
    [self.tb_shoppingCart requestDataSource];
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [ShoppingHandler getShoppingListWithPrepare:^{
        
    } success:^(id obj) {
        self.shoppingCarEntity = (ShoppingCarEntity *)obj;
        [self refreshUI];
        complete([self.arr_data count]);
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)refreshUI{
    [self.arr_data removeAllObjects];
    [self.arr_data addObjectsFromArray:self.shoppingCarEntity.shoppingCarShops];
    if (self.shoppingCarEntity.invalidItems.count > 0) {
        StoreEntity *entity = [[StoreEntity alloc]init];
        entity.name = @"失效商品";
        entity.shoppingCatItems = self.shoppingCarEntity.invalidItems;
        [self.arr_data addObject:entity];
    }
    [self.arr_select removeAllObjects];
    for (int i = 0; i < self.arr_data.count; i++) {
        StoreEntity *entity = [[self.arr_data objectAtIndex:i] copy];
        entity.shoppingCatItems = @[];
        [self.arr_select addObject:entity];
    }
    [self.v_bottomNormal.btn_selectAll setSelected:NO];
    [self getAllPrice];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
    return storeEntity.shoppingCatItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42)];
    [v_header setBackgroundColor:[UIColor whiteColor]];
    UIButton *btn_select = [[UIButton alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
    [btn_select setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [btn_select setImage:[UIImage imageNamed:@"payComplete"] forState:UIControlStateSelected];
    btn_select.tag = section;
    [btn_select addTarget:self action:@selector(selectSectionAction:) forControlEvents:UIControlEventTouchUpInside];
    v_header.tag = section;
    UITapGestureRecognizer *vHeaderTgp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vHeaderTgp:)];
    [v_header addGestureRecognizer:vHeaderTgp];
    [v_header addSubview:btn_select];
    
    UIImageView *iv_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(btn_select.right + 10, 10, 22, 22)];
    iv_avatar.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [iv_avatar.layer setCornerRadius:11];
    [iv_avatar.layer setMasksToBounds:YES];
    iv_avatar.contentMode = UIViewContentModeScaleAspectFill;
    [v_header addSubview:iv_avatar];
    
    UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(iv_avatar.right + 10, 0, SCREEN_WIDTH - iv_avatar.right - 42, 42)];
    [lb_title setFont:[UIFont systemFontOfSize:14]];
    [lb_title setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [v_header addSubview:lb_title];
    
    UIImageView *iv_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 15, 9, 24, 24)];
    [iv_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
    [v_header addSubview:iv_arrow];

    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
    StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:section];
    [iv_avatar sd_setImageWithURL:[NSURL URLWithString:storeEntity.logo] placeholderImage:nil];
    [btn_select setSelected:selectStoreEntity.isSelected];
    [lb_title setText:storeEntity.name];
    if ([storeEntity.name isEqualToString:@"失效商品"]) {
        [iv_avatar setHidden:YES];
        [btn_select setHidden:YES];
        [iv_arrow setHidden:YES];
        [lb_title setFrame:CGRectMake(10, 0, SCREEN_WIDTH - 100, 42)];
        [lb_title setText:storeEntity.name];
        UIButton *btn_delete = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 0, 50, 42)];
        [btn_delete setTitle:@"清空" forState:UIControlStateNormal];
        [btn_delete setTitleColor:[UIColor colorWithHexString:@"#E6670C"] forState:UIControlStateNormal];
        [btn_delete.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btn_delete.tag = section;
        [btn_delete addTarget:self action:@selector(deleteInvalidAction) forControlEvents:UIControlEventTouchUpInside];
        [v_header addSubview:btn_delete];
    }
    
    return v_header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42 + 10)];
    [v_footer setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lb_StartingPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 250, 42)];
    [lb_StartingPrice setFont:[UIFont systemFontOfSize:14]];
    [lb_StartingPrice setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [v_footer addSubview:lb_StartingPrice];
    
    UILabel *lb_amount = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, SCREEN_WIDTH - 170, 42)];
    [lb_amount setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [lb_amount setFont:[UIFont systemFontOfSize:16]];
    [lb_amount setTextAlignment:NSTextAlignmentRight];
    [v_footer addSubview:lb_amount];
    
    StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:section];
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];

    double sectionAmount = 0.00;
    for (SupplierCommodityEndity *entity in selectStoreEntity.shoppingCatItems) {
        sectionAmount = sectionAmount + entity.count * entity.price;
    }
    NSString *str_sectionAmount = [NSString stringWithFormat:@"合计：￥%.2f",sectionAmount];
    NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:str_sectionAmount];
    [str_amount addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, 3)];
    [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    [lb_amount setAttributedText:str_amount];
    
    NSString *str_takeOffPrice = [NSString stringWithFormat:@"%d元起送",(int)selectStoreEntity.takeOffPrice];
    NSString *str_all = str_takeOffPrice;
    if (self.editStatus == 0) {
        if ((sectionAmount - selectStoreEntity.takeOffPrice) >= 0) {
        }else{
            str_all = [str_all stringByAppendingString:[NSString stringWithFormat:@"    还差%.2f元起送",selectStoreEntity.takeOffPrice - sectionAmount]];
        }
    }
    
    NSMutableAttributedString *str_allTakeOffPrice = [[NSMutableAttributedString alloc]initWithString:str_all];
    [str_allTakeOffPrice addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, str_takeOffPrice.length)];
    [lb_StartingPrice setAttributedText:str_allTakeOffPrice];
    
    UIView *v_line = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 10)];
    [v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [v_footer addSubview:v_line];
    
    if (self.editStatus == 1) {
        [lb_StartingPrice setHidden:YES];
    }else{
        [lb_StartingPrice setHidden:NO];
    }
    
    if ([storeEntity.name isEqualToString:@"失效商品"]) {
        return nil;
    }else{
        return v_footer;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:indexPath.section];
    if (![storeEntity.name isEqualToString:@"失效商品"]) {
        static NSString *identifier = @"shoppingCell";
        ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        SupplierCommodityEndity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:indexPath.row];
        [cell contentCellWithWareEntity:wareEntity];
        cell.btn_select.tag = indexPath.section*1000 + indexPath.row;
        [cell.btn_select addTarget:self action:@selector(selectRowAction:) forControlEvents:UIControlEventTouchUpInside];
        StoreEntity *selectStore = [self.arr_select objectAtIndex:indexPath.section];
        if ([selectStore.shoppingCatItems containsObject:wareEntity]) {
            [cell.btn_select setSelected:YES];
        }else{
            [cell.btn_select setSelected:NO];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.btn_less.tag = indexPath.section * 1000 + indexPath.row;
        cell.btn_plus.tag = indexPath.section * 1000 + indexPath.row;
        [cell.btn_less addTarget:self action:@selector(lessAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_plus addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        static NSString *identifier = @"shoppingInvalidCell";
        ShoppingInvalidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ShoppingInvalidTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SupplierCommodityEndity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:indexPath.row];
        [cell contentCellWithWareEntity:wareEntity];
        return cell;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        StoreEntity *storeEntity = [self.arr_data objectAtIndex:indexPath.section];
        SupplierCommodityEndity *entity = [storeEntity.shoppingCatItems objectAtIndex:indexPath.row];
        [ShoppingHandler deleteShopSingleCommodityWithSkuId:entity.skuId skuUnitId:entity.skuUnitId prepare:^{
            [MBProgressHUD showActivityMessageInView:nil];
        } success:^(id obj) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccessMessage:@"删除成功"];
            StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:indexPath.section];
            NSMutableArray *arr_data = [NSMutableArray arrayWithArray:storeEntity.shoppingCatItems];
            NSMutableArray *arr_selectData = [NSMutableArray arrayWithArray:selectStoreEntity.shoppingCatItems];
            
            if ([arr_selectData containsObject:[arr_data objectAtIndex:indexPath.row]]) {
                [arr_selectData removeObject:[arr_data objectAtIndex:indexPath.row]];
                selectStoreEntity.shoppingCatItems = arr_selectData;
                [self.arr_select replaceObjectAtIndex:indexPath.section withObject:selectStoreEntity];
            }
            [arr_data removeObjectAtIndex:indexPath.row];
            if (arr_data.count == 0) {
                [self.arr_data removeObjectAtIndex:indexPath.section];
                [self.arr_select removeObjectAtIndex:indexPath.section];
            }else{
                storeEntity.shoppingCatItems = arr_data;
                [self.arr_data replaceObjectAtIndex:indexPath.section withObject:storeEntity];
            }
            [self.tb_shoppingCart reloadData];
            [(PurchaseTabBarViewController *)self.tabBarController showBadgeOnItemIndex:1 withCount:[(PurchaseTabBarViewController *)self.tabBarController unViewedCount] - 1];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
    if (![storeEntity.name isEqualToString:@"失效商品"]) {
        SupplierCommodityEndity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:row];
        StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:section];
        NSMutableArray *arr_select = [NSMutableArray arrayWithArray:selectStoreEntity.shoppingCatItems];
        if ([arr_select containsObject:wareEntity]) {
            [arr_select removeObject:wareEntity];
        }else{
            [arr_select addObject:wareEntity];
        }
        selectStoreEntity.shoppingCatItems = arr_select;
        [self.arr_select replaceObjectAtIndex:section withObject:selectStoreEntity];
        [self.tb_shoppingCart reloadData];
        [self getAllPrice];
    }
}

- (void)lessAction:(UIButton *)btn_sender{
    NSInteger section = btn_sender.tag / 1000;
    NSInteger row = btn_sender.tag % 1000;
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
    SupplierCommodityEndity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:row];
    if (wareEntity.count > 1) {
        [PurchaseHandler addCommodityToShoppingCarWithSkuId:wareEntity.skuId skuUnitId:wareEntity.skuUnitId count:[NSNumber numberWithInt:-1] prepare:^{
        } success:^(id obj) {
            wareEntity.count = wareEntity.count - 1;
            [self.tb_shoppingCart reloadData];
            [self getAllPrice];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
}

- (void)plusAction:(UIButton *)btn_sender{
    NSInteger section = btn_sender.tag / 1000;
    NSInteger row = btn_sender.tag % 1000;
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
    SupplierCommodityEndity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:row];
    [PurchaseHandler addCommodityToShoppingCarWithSkuId:wareEntity.skuId skuUnitId:wareEntity.skuUnitId count:[NSNumber numberWithInt:1] prepare:^{
    } success:^(id obj) {
        wareEntity.count = wareEntity.count + 1;
        [self.tb_shoppingCart reloadData];
        [self getAllPrice];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
    
}

- (void)deleteInvalidAction{
    [ShoppingHandler shoppingRemoveWithPrepare:^{
        [MBProgressHUD showActivityMessageInView:nil];
    } success:^(id obj) {
        [MBProgressHUD hideHUD];
        [self.arr_select removeLastObject];
        [self.arr_data removeLastObject];
        [self.tb_shoppingCart reloadData];
        [self loadShoppingCount];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)selectSectionAction:(UIButton *)btn_sender{
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:btn_sender.tag];
    StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:btn_sender.tag];
    if (selectStoreEntity.isSelected == NO) {
        selectStoreEntity.isSelected = YES;
        selectStoreEntity.shoppingCatItems = storeEntity.shoppingCatItems;
    }else{
        selectStoreEntity.isSelected = NO;
        selectStoreEntity.shoppingCatItems = [NSArray array];
    }
    [self.arr_select replaceObjectAtIndex:btn_sender.tag withObject:selectStoreEntity];
    [self.tb_shoppingCart reloadData];
    [self getAllPrice];
}

- (void)selectRowAction:(UIButton *)btn_sender{
    NSInteger section = btn_sender.tag / 1000;
    NSInteger row = btn_sender.tag % 1000;
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
    SupplierCommodityEndity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:row];
    StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:section];
    NSMutableArray *arr_select = [NSMutableArray arrayWithArray:selectStoreEntity.shoppingCatItems];
    if ([arr_select containsObject:wareEntity]) {
        [arr_select removeObject:wareEntity];
        selectStoreEntity.isSelected = NO;
    }else{
        [arr_select addObject:wareEntity];
    }
    selectStoreEntity.shoppingCatItems = arr_select;
    [self.arr_select replaceObjectAtIndex:section withObject:selectStoreEntity];
    [self.tb_shoppingCart reloadData];
    [self getAllPrice];
}

- (void)selectAllAction{
    [self.v_bottomNormal.btn_selectAll setSelected:!self.v_bottomNormal.btn_selectAll.isSelected];
    if (self.v_bottomNormal.btn_selectAll.isSelected == YES) {
        [self.arr_select removeAllObjects];
        for (int i = 0; i < self.arr_data.count; i++) {
            StoreEntity *entity = [[self.arr_data objectAtIndex:i] copy];
            entity.isSelected = YES;
            [self.arr_select addObject:entity];
        }
    }else{
        [self.arr_select removeAllObjects];
        for (int i = 0; i < self.arr_data.count; i++) {
            StoreEntity *entity = [[self.arr_data objectAtIndex:i] copy];
            entity.shoppingCatItems = @[];
            [self.arr_select addObject:entity];
        }
    }
    [self.tb_shoppingCart reloadData];
    [self getAllPrice];
}

- (void)getAllPrice{
    double double_allPrice = 0.00;
    for (StoreEntity *selectStoreEntity in self.arr_select) {
        for (SupplierCommodityEndity *selectWareEntity in selectStoreEntity.shoppingCatItems) {
            double_allPrice = double_allPrice + selectWareEntity.price * selectWareEntity.count;
        }
    }
    NSString *str_allPrice = [NSString stringWithFormat:@"合计：￥%.2f",double_allPrice];
    NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:str_allPrice];
    [str_amount addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, 3)];
    [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    [self.v_bottomNormal.lb_allPrice setAttributedText:str_amount];
    
    if (double_allPrice > 0) {
        BOOL isCheck = NO;
        for (StoreEntity *storeEntity in self.arr_select) {
            double sectionAmount = 0.00;
            for (SupplierCommodityEndity *entity in storeEntity.shoppingCatItems) {
                sectionAmount = sectionAmount + entity.count * entity.price;
            }
            if (sectionAmount >= storeEntity.takeOffPrice) {
                isCheck = YES;
            }
        }
        if (isCheck == YES) {
            if (self.editStatus == 0) {
                [self.v_bottomNormal.btn_checkout setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
            }else{
                [self.v_bottomNormal.btn_checkout setBackgroundColor:[UIColor colorWithHexString:@"#E6670C"]];
            }
            [self.v_bottomNormal.btn_checkout setEnabled:YES];
        }else{
            [self.v_bottomNormal.btn_checkout setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
            [self.v_bottomNormal.btn_checkout setEnabled:NO];
        }
    }else{
        [self.v_bottomNormal.btn_checkout setBackgroundColor:[UIColor colorWithHexString:@"#C2C2C2"]];
        [self.v_bottomNormal.btn_checkout setEnabled:NO];
    }
        
}

- (void)checkAction{
    if (self.editStatus == 0) {
        //获取默认地址
        [PurchaseHandler selectDefaultAddressWithPrepare:^{
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                AddressEntity *entity = [AddressEntity parseAddressEntityWithJson:[(NSDictionary *)obj objectForKey:@"data"]];
                NSMutableArray *arr_selectResult = [NSMutableArray array];
                for (int i = 0; i < self.arr_select.count; i++) {
                    StoreEntity *storeEntity = [[self.arr_select objectAtIndex:i] copy];
                    double sectionAmount = 0.00;
                    for (SupplierCommodityEndity *entity in storeEntity.shoppingCatItems) {
                        sectionAmount = sectionAmount + entity.count * entity.price;
                    }
                    if (sectionAmount > storeEntity.takeOffPrice) {
                        [arr_selectResult addObject:storeEntity];
                    }
                }
                ConfirmOrderViewController *vc = [[ConfirmOrderViewController alloc]init];
                vc.arr_selectedData = arr_selectResult;
                vc.hidesBottomBarWhenPushed = YES;
                vc.addressEntity = entity;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }else{
        //批量删除
        NSMutableArray *arr_data = [NSMutableArray array];
        for (StoreEntity *selectStoreEntity in self.arr_select) {
            for (SupplierCommodityEndity *entity in selectStoreEntity.shoppingCatItems) {
                if ([entity.skuUnitId intValue] > 0) {
                    [arr_data addObject:@{@"skuId":entity.skuId,@"skuUnitId":entity.skuUnitId}];
                }else{
                    [arr_data addObject:@{@"skuId":entity.skuId}];
                }
            }
        }
        [ShoppingHandler deleteShopMoreCommodityWithCommodityArray:arr_data prepare:^{
            [MBProgressHUD showActivityMessageInView:nil];
        } success:^(id obj) {
            [MBProgressHUD hideHUD];
            self.shoppingCarEntity = (ShoppingCarEntity *)obj;
            [self refreshUI];
            [self.tb_shoppingCart reloadData];
            [self loadShoppingCount];
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
}

- (void)leftBarAction:(id)sender{
    TabBarViewController *vc = [[TabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (void)editAction{
    if (self.editStatus == 0) {
        self.editStatus = 1;
        [self.btn_right setTitle:@"完成"];
        [self.v_bottomNormal.lb_allPrice setHidden:YES];
        [self.v_bottomNormal.btn_checkout setBackgroundColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.v_bottomNormal.btn_checkout setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        self.editStatus = 0;
        [self.btn_right setTitle:@"编辑"];
        [self.v_bottomNormal.btn_checkout setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        [self.v_bottomNormal.lb_allPrice setHidden:NO];
        [self.v_bottomNormal.btn_checkout setTitle:@"结算" forState:UIControlStateNormal];
    }
    [self.tb_shoppingCart reloadData];
    [self getAllPrice];
}

- (void)vHeaderTgp:(UITapGestureRecognizer *)tap{
    UIView *v_sender = [tap view];
    StoreEntity *entity = [self.arr_data objectAtIndex:v_sender.tag];
    if (![entity.name isEqualToString:@"失效商品"]) {
        SupplierShopViewController *vc = [[SupplierShopViewController alloc]init];
        vc.storeEntity = entity;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)NocatifionPayCompleteAndRefreshDataAction{
    [self.tb_shoppingCart requestDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
