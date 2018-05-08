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
#import "WareEntity.h"
#import "ShoppingHandler.h"
#import "ShoppingBottomView.h"

@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic,strong)BaseTableView     *tb_shoppingCart;
@property (nonatomic,strong)NSMutableArray    *arr_data;
@property (nonatomic,strong)ShoppingCarEntity *shoppingCarEntity;
@property (nonatomic,strong)NSMutableArray    *arr_select;
@property (nonatomic,strong)ShoppingBottomView  *v_bottomNormal;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    self.arr_data = [NSMutableArray array];
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
    [self.view addSubview:self.v_bottomNormal];
    
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [ShoppingHandler getShoppingListWithPrepare:^{
        
    } success:^(id obj) {
        self.shoppingCarEntity = (ShoppingCarEntity *)obj;
        [self.arr_data removeAllObjects];
        [self.arr_data addObjectsFromArray:self.shoppingCarEntity.shoppingCarShops];
        if (self.shoppingCarEntity.invalidItems.count > 0) {
            StoreEntity *entity = [[StoreEntity alloc]init];
            entity.shopName = @"失效商品";
            entity.shoppingCatItems = self.shoppingCarEntity.invalidItems;
            [self.arr_data addObject:entity];
        }
        [self.arr_select removeAllObjects];
        for (int i = 0; i < self.arr_data.count; i++) {
            StoreEntity *entity = [self.arr_data objectAtIndex:i];
            entity.shoppingCatItems = @[];
            [self.arr_select addObject:entity];
        }
        [self.tb_shoppingCart reloadData];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr_data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42)];

    UIButton *btn_select = [[UIButton alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
    [btn_select setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [btn_select setImage:[UIImage imageNamed:@"payComplete"] forState:UIControlStateSelected];
    btn_select.tag = section;
    [btn_select addTarget:self action:@selector(selectSectionAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [v_header addSubview:btn_select];
    
    UIImageView *iv_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(btn_select.right + 10, 10, 22, 22)];
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
    [iv_avatar sd_setImageWithURL:[NSURL URLWithString:storeEntity.shopPicurl] placeholderImage:nil];
    [lb_title setText:storeEntity.shopName];
    
    return v_header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42 + 10)];
    [v_footer setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    
    UILabel *lb_StartingPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 42)];
    [lb_StartingPrice setFont:[UIFont systemFontOfSize:14]];
    [lb_StartingPrice setTextColor:[UIColor blackColor]];
    [v_footer addSubview:lb_StartingPrice];
    
    UILabel *lb_amount = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, SCREEN_WIDTH - 170, 42)];
    [lb_amount setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
    [lb_amount setFont:[UIFont systemFontOfSize:16]];
    [v_footer addSubview:lb_amount];
    
    StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:section];
    [lb_StartingPrice setText:[NSString stringWithFormat:@"%d元起送",(int)selectStoreEntity.shopTakeOffPrice]];
    double sectionAmount = 0.00;
    for (WareEntity *entity in selectStoreEntity.shoppingCatItems) {
        sectionAmount = sectionAmount + entity.wareCount * entity.warePrice;
    }
    NSString *str_sectionAmount = [NSString stringWithFormat:@"合计：￥%.2f",sectionAmount];
    NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:str_sectionAmount];
    [str_amount addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, 3)];
    [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    [lb_amount setAttributedText:str_amount];
    return v_footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"shoppingCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:indexPath.section];
    WareEntity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:indexPath.row];
    [cell contentCellWithWareEntity:wareEntity];
    cell.btn_select.tag = indexPath.section*100 + indexPath.row;
    [cell.btn_select addTarget:self action:@selector(selectRowAction:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *arr_select = [self.arr_select objectAtIndex:indexPath.section];
    if ([arr_select containsObject:wareEntity]) {
        [cell.btn_select setSelected:YES];
    }else{
        [cell.btn_select setSelected:NO];
    }
    return cell;
}

- (void)selectSectionAction:(UIButton *)btn_sender{
    StoreEntity *storeEntity = [self.arr_data objectAtIndex:btn_sender.tag];
    StoreEntity *selectStoreEntity = [self.arr_select objectAtIndex:btn_sender.tag];
    if (storeEntity.isSelected == NO) {
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
    WareEntity  *wareEntity = [storeEntity.shoppingCatItems objectAtIndex:row];
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
        self.arr_select = self.arr_data;
    }else{
        [self.arr_select removeAllObjects];
        for (int i = 0; i < self.arr_data.count; i++) {
            StoreEntity *entity = [self.arr_data objectAtIndex:i];
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
        for (WareEntity *selectWareEntity in selectStoreEntity.shoppingCatItems) {
            double_allPrice = double_allPrice + selectWareEntity.warePrice * selectWareEntity.wareCount;
        }
    }
    NSString *str_allPrice = [NSString stringWithFormat:@"合计：￥%.2f",double_allPrice];
    NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:str_allPrice];
    [str_amount addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, 3)];
    [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    [self.v_bottomNormal.lb_allPrice setAttributedText:str_amount];
}

- (void)leftBarAction:(id)sender{
    TabBarViewController *vc = [[TabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
