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
#import "ConfirmOrderViewController.h"

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

- (void)onCreate{
    
    self.tb_shoppingCart = [[BaseTableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 49 - 46) style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:NO];
    self.tb_shoppingCart.delegate = self;
    self.tb_shoppingCart.dataSource = self;
    self.tb_shoppingCart.tableViewDelegate = self;
    self.tb_shoppingCart.tableFooterView = [UIView new];
    self.tb_shoppingCart.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.view addSubview:self.tb_shoppingCart];
    
    self.v_bottomNormal = [[ShoppingBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight - 49 - 46, SCREEN_WIDTH, 46)];
    [self.v_bottomNormal.btn_selectAll addTarget:self action:@selector(selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_bottomNormal.btn_checkout addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.v_bottomNormal];
    
    [self.tb_shoppingCart requestDataSource];
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [ShoppingHandler getShoppingListWithPrepare:^{
        
    } success:^(id obj) {
        self.shoppingCarEntity = (ShoppingCarEntity *)obj;
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
        complete([self.arr_data count]);
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
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
    
    UIImageView *iv_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 8, 14.5, 13, 13)];
    [iv_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
    [v_header addSubview:iv_arrow];

    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
    StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:section];
    [iv_avatar sd_setImageWithURL:[NSURL URLWithString:storeEntity.logo] placeholderImage:nil];
    [btn_select setSelected:selectStoreEntity.isSelected];
    [lb_title setText:storeEntity.name];
    
    return v_header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42 + 10)];
    [v_footer setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lb_StartingPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 42)];
    [lb_StartingPrice setFont:[UIFont systemFontOfSize:14]];
    [lb_StartingPrice setTextColor:[UIColor blackColor]];
    [v_footer addSubview:lb_StartingPrice];
    
    UILabel *lb_amount = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, SCREEN_WIDTH - 170, 42)];
    [lb_amount setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [lb_amount setFont:[UIFont systemFontOfSize:16]];
    [lb_amount setTextAlignment:NSTextAlignmentRight];
    [v_footer addSubview:lb_amount];
    
    StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:section];
    [lb_StartingPrice setText:[NSString stringWithFormat:@"%d元起送",(int)selectStoreEntity.takeOffPrice]];
    double sectionAmount = 0.00;
    for (SupplierCommodityEndity *entity in selectStoreEntity.shoppingCatItems) {
        sectionAmount = sectionAmount + entity.count * entity.price;
    }
    NSString *str_sectionAmount = [NSString stringWithFormat:@"合计：￥%.2f",sectionAmount];
    NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:str_sectionAmount];
    [str_amount addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, 3)];
    [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    [lb_amount setAttributedText:str_amount];
    
    UIView *v_line = [[UIView alloc]initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 10)];
    [v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [v_footer addSubview:v_line];
    
    return v_footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"shoppingCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:indexPath.section];
    SupplierCommodityEndity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:indexPath.row];
    [cell contentCellWithWareEntity:wareEntity];
    cell.btn_select.tag = indexPath.section*100 + indexPath.row;
    [cell.btn_select addTarget:self action:@selector(selectRowAction:) forControlEvents:UIControlEventTouchUpInside];
    StoreEntity *selectStore = [self.arr_select objectAtIndex:indexPath.section];
    if ([selectStore.shoppingCatItems containsObject:wareEntity]) {
        [cell.btn_select setSelected:YES];
    }else{
        [cell.btn_select setSelected:NO];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
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
    NSInteger section = btn_sender.tag / 100;
    NSInteger row = btn_sender.tag % 100;
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:section];
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
}

- (void)checkAction{
    if (self.editStatus == 0) {
        ConfirmOrderViewController *vc = [[ConfirmOrderViewController alloc]init];
        vc.arr_selectedData = self.arr_select;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //批量删除
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
