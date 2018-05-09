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
@interface SupplierShopViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)BaseTableView   *tb_left;
@property (nonatomic,strong)BaseTableView   *tb_right;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SupplierCommodityTableViewCell";
    SupplierCommodityTableViewCell *cell = (SupplierCommodityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[SupplierCommodityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
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
