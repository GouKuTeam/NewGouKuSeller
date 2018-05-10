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

@interface SupplierShopViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)BaseTableView   *tb_left;
@property (nonatomic,strong)BaseTableView   *tb_right;
@property (nonatomic,strong)UIBarButtonItem *btn_attention;
@property (nonatomic,strong)NSMutableArray  *arr_category;
@property (nonatomic,strong)NSMutableArray  *arr_data;

@end

@implementation SupplierShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    self.tb_left = [[BaseTableView alloc]initWithFrame:CGRectMake(0,v_header.bottom,85,SCREEN_HEIGHT - v_header.bottom - SafeAreaBottomHeight - SafeAreaTopHeight) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_left.delegate = self;
    self.tb_left.dataSource = self;
    self.tb_left.tableFooterView = [UIView new];
    self.tb_left.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tb_left];
    
    self.tb_right = [[BaseTableView alloc]initWithFrame:CGRectMake(85,self.tb_left.top,SCREEN_WIDTH - 85,self.tb_left.height) style:UITableViewStyleGrouped hasHeaderRefreshing:NO hasFooterRefreshing:NO];
    self.tb_right.delegate = self;
    self.tb_right.dataSource = self;
    self.tb_right.tableFooterView = [UIView new];
    self.tb_right.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tb_right];
    
    UIBarButtonItem *btn_search = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_white"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    self.btn_attention = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shoucang-white"] style:UIBarButtonItemStyleDone target:self action:@selector(attentionAction)];
    if (self.storeEntity.isAttention == YES) {
        [_btn_attention setImage:[UIImage imageNamed:@"shocuang-orange"]];
    }
    self.navigationItem.rightBarButtonItems = @[self.btn_attention,btn_search];
}

- (void)searchAction{
    
}

- (void)attentionAction{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tb_left == tableView) {
        static NSString *CellIdentifier = @"SupplierCommodityTableViewCell";
        SupplierCommodityTableViewCell *cell = (SupplierCommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell){
            cell = [[SupplierCommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
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
        return v_header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section:(NSInteger)section{
    return nil;
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
    }
}

@end
