//
//  SupplierShopViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierShopViewController.h"
#import "SupplierHeaderView.h"
#import "SupplierCommodityTableViewCell.h"
#import "CategoryTableViewCell.h"
#import "CommodityHandler.h"
#import "ShopClassificationEntity.h"
#import "SupplierCommodityHeaderView.h"

@interface SupplierShopViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,BaseTableViewDelagate>

@property (nonatomic,strong)BaseTableView   *tb_left;
@property (nonatomic,strong)BaseTableView   *tb_right;
@property (nonatomic,strong)UIBarButtonItem *btn_attention;
@property (nonatomic,strong)NSMutableArray  *arr_category;
@property (nonatomic,strong)NSMutableArray  *arr_data;
@property (nonatomic,assign)int              selectedFirst;
@property (nonatomic,strong)SupplierCommodityHeaderView  *v_supplierCommodityHeader;
@property (nonatomic,strong)UIView          *v_line;

@end

@implementation SupplierShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arr_category = [NSMutableArray array];
    self.arr_data = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:[UIColor colorWithHexString:COLOR_Main] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationOriginal];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)onCreate{
    
    SupplierHeaderView *v_header = [[SupplierHeaderView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 66)];
    [v_header.iv_avatar sd_setImageWithURL:[NSURL URLWithString:self.storeEntity.logo] placeholderImage:nil];
    [v_header.lb_name setText:self.storeEntity.name];
    [v_header.lb_startPrice setText:[NSString stringWithFormat:@"%d元起送",(int)self.storeEntity.takeOffPrice]];
    [self.view addSubview:v_header];
    
    self.v_supplierCommodityHeader = [[SupplierCommodityHeaderView alloc]init];
    self.v_supplierCommodityHeader.backgroundColor = [UIColor yellowColor];
    self.v_supplierCommodityHeader.clipsToBounds = YES;
    
    self.tb_left = [[BaseTableView alloc]initWithFrame:CGRectMake(0,v_header.bottom,85,SCREEN_HEIGHT - v_header.bottom - SafeAreaBottomHeight - SafeAreaTopHeight) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_left.delegate = self;
    self.tb_left.dataSource = self;
    self.tb_left.tableFooterView = [UIView new];
    self.tb_left.separatorColor = [UIColor clearColor];
    self.tb_left.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tb_left];
    
    self.tb_right = [[BaseTableView alloc]initWithFrame:CGRectMake(85,self.tb_left.top,SCREEN_WIDTH - 85,self.tb_left.height) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_right.delegate = self;
    self.tb_right.dataSource = self;
    self.tb_right.tableViewDelegate = self;
    self.tb_right.tableFooterView = [UIView new];
    self.tb_right.rowHeight = 72;
    self.tb_right.backgroundColor = [UIColor whiteColor];
    self.tb_right.tableHeaderView = self.v_supplierCommodityHeader;
    [self.view addSubview:self.tb_right];
    
    self.v_line = [[UIView alloc]initWithFrame:CGRectMake(85, self.tb_left.top, 1,self.tb_left.height)];
    [self.view addSubview:self.v_line];
    
    UIBarButtonItem *btn_search = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_white"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    self.btn_attention = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shoucang-white"] style:UIBarButtonItemStyleDone target:self action:@selector(attentionAction)];
    if (self.storeEntity.isAttention == YES) {
        [_btn_attention setImage:[UIImage imageNamed:@"shocuang-orange"]];
    }
    self.navigationItem.rightBarButtonItems = @[self.btn_attention,btn_search];
    
    [self loadData];
}

- (void)searchAction{
    
}

- (void)attentionAction{
    
}

- (void)loadData{
    [CommodityHandler getCommodityCategoryWithShopId:[self.storeEntity.shopId stringValue] prepare:^{
        [MBProgressHUD showActivityMessageInView:nil];
    } success:^(id obj) {
        [MBProgressHUD hideHUD];
        NSArray *arr_data = (NSArray *)obj;
        [self.arr_category removeAllObjects];
        [self.arr_category addObjectsFromArray:arr_data];
        self.selectedFirst = 0;
        [self.tb_left reloadData];
        [self reloadSupplierCommodityHeaderView];
        [self.tb_right requestDataSource];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    
}

- (void)reloadSupplierCommodityHeaderView{
    if (self.arr_category.count > 0) {
        ShopClassificationEntity *entity = [self.arr_category objectAtIndex:self.selectedFirst];
        self.v_supplierCommodityHeader.arr_data = entity.childList;
        if (entity.childList > 0) {
            CGFloat  height = 0.00;
            if (entity.childList.count % 3 == 0) {
                height = 30 + entity.childList.count/3*34 + (entity.childList.count/3 - 1)*7;
            }else{
                height = 30 + (entity.childList.count/3 + 1)*34 + (entity.childList.count/3 + 1 - 1)*7;
            }
            [self.v_supplierCommodityHeader setFrame:CGRectMake(0,0, self.v_supplierCommodityHeader.width, height)];
        }else{
            [self.v_supplierCommodityHeader setFrame:CGRectZero];
        }
    }
    [self.tb_right setTableHeaderView:self.v_supplierCommodityHeader];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tb_left){
        return self.arr_category.count;
    }else{
        return self.arr_data.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tb_left == tableView) {
        static NSString *CellIdentifier = @"SupplierCommodityTableViewCell";
        CategoryTableViewCell *cell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ShopClassificationEntity *entity = [self.arr_category objectAtIndex:indexPath.row];
        if (indexPath.row == self.selectedFirst) {
            cell.lb_name.textColor = [UIColor blackColor];
        }else{
            cell.lb_name.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        }
        cell.lb_name.text = entity.name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"SupplierCommodityTableViewCell";
        SupplierCommodityTableViewCell *cell = (SupplierCommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[SupplierCommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_left) {
        return 0.01;
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tb_left) {
        return nil;
    }else{
        UIView *v_header = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tb_right.width, 30)];
        [v_header setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *lb_title = [[UILabel alloc]initWithFrame:CGRectMake(7, 0, self.tb_right.width - 14, 30)];
        [lb_title setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        [v_header addSubview:lb_title];
        
        if (self.arr_category.count > 0) {
            ShopClassificationEntity *entity = [self.arr_category objectAtIndex:self.selectedFirst];
            lb_title.text = entity.name;
        }
        return v_header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tb_left) {
        self.selectedFirst = (int)indexPath.row;
        [self reloadSupplierCommodityHeaderView];
        [self.tb_left reloadData];
        [self.tb_right requestDataSource];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == self.tb_left) {
//        if (self.tb_left.top <= 66 && self.tb_left.top > 0  && scrollView.contentOffset.y
//             > 0) {
//            CGFloat heightTop = self.tb_left.top - scrollView.contentOffset.y;
//            if (heightTop < 0) {
//                heightTop = 0;
//            }
//            [self.tb_left setFrame:CGRectMake(self.tb_left.left,heightTop, self.tb_left.width, SCREEN_HEIGHT - heightTop - SafeAreaBottomHeight - SafeAreaTopHeight)];
//            [self.tb_left setContentOffset:CGPointMake(0, 0)];
//            [self.tb_right setFrame:CGRectMake(self.tb_right.left,self.tb_left.top, self.tb_right.width,self.tb_left.height)];
//        }else if (self.tb_left.top <= 66 && scrollView.contentOffset.y < 0){
//            CGFloat heightTop = self.tb_left.top - scrollView.contentOffset.y;
//            if (heightTop > 66) {
//                heightTop = 66;
//            }
//            [self.tb_left setFrame:CGRectMake(self.tb_left.left,heightTop,self.tb_left.width, SCREEN_HEIGHT - heightTop - SafeAreaBottomHeight - SafeAreaTopHeight)];
//            [self.tb_left setContentOffset:CGPointMake(0, 0)];
//            [self.tb_right setFrame:CGRectMake(self.tb_right.left,self.tb_left.top, self.tb_right.width,self.tb_left.height)];
//        }
//    }
     if (scrollView == self.tb_right){
        if (self.tb_right.top <= 66 && self.tb_left.top > 0 && scrollView.contentOffset.y
            > 0) {
            CGFloat heightTop = self.tb_right.top - scrollView.contentOffset.y;
            if (heightTop < 0) {
                heightTop = 0;
            }
            [self.tb_right setFrame:CGRectMake(self.tb_right.left,heightTop, self.tb_right.width,SCREEN_HEIGHT - heightTop - SafeAreaBottomHeight - SafeAreaTopHeight)];
            [self.tb_right setContentOffset:CGPointMake(0, 0)];
            [self.tb_left setFrame:CGRectMake(self.tb_left.left, self.tb_right.top, self.tb_left.width, self.tb_right.height)];
        }else if (self.tb_right.top <= 66 && scrollView.contentOffset.y < 0){
            CGFloat heightTop = self.tb_right.top - scrollView.contentOffset.y;
            if (heightTop > 66) {
                heightTop = 66;
            }
            [self.tb_right setFrame:CGRectMake(self.tb_right.left,heightTop, self.tb_right.width,SCREEN_HEIGHT - heightTop - SafeAreaBottomHeight - SafeAreaTopHeight)];
            [self.tb_right setContentOffset:CGPointMake(0, 0)];
            [self.tb_left setFrame:CGRectMake(self.tb_left.left, self.tb_right.top, self.tb_left.width,self.tb_right.height)];
        }
        [self.v_line setFrame:CGRectMake(85, self.tb_left.top, 1,self.tb_left.height)];
    }
}

@end
