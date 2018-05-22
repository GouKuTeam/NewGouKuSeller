//
//  CustomerManagerViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CustomerManagerViewController.h"
#import "SearchCustomerViewController.h"
#import "CustomerManagerTableViewCell.h"
#import "CustomerManagerEntity.h"
#import "CustomerManagerHandler.h"
#import "CustomerShopInformationViewController.h"

@interface CustomerManagerViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic ,strong)BaseTableView                *tb_customer;
@property (nonatomic ,strong)NSMutableArray               *arr_customer;

@end

@implementation CustomerManagerViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_customer = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"客户管理";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(searchBarAction)];
    [btn_right setImage:[UIImage imageNamed:@"home_search"]];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    self.tb_customer = [[BaseTableView alloc]initWithFrame:CGRectMake(0,10, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaBottomHeight - 10) style:UITableViewStylePlain hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    [self.view addSubview:self.tb_customer];
    self.tb_customer.delegate = self;
    self.tb_customer.dataSource = self;
    self.tb_customer.tableViewDelegate = self;
    self.tb_customer.tableFooterView = [UIView new];
    self.tb_customer.rowHeight = 69;
    self.tb_customer.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
    [self.tb_customer requestDataSource];
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [CustomerManagerHandler getCustomerListWithPage:(int)pageNum prepare:^{
        
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_customer removeAllObjects];
        }
        [self.arr_customer addObjectsFromArray:(NSArray *)obj];
        [self.tb_customer reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_customer.count == 0) {
            self.tb_customer.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_customer.frame withDefaultImage:nil withNoteTitle:@"您还没有客户，客户下单后会自动成为您的客户" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_customer.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CustomerManagerTableViewCell";
    CustomerManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomerManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CustomerManagerEntity *entity = [self.arr_customer objectAtIndex:indexPath.row];
    [cell contentCellWithCustomerManagerEntity:entity];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CustomerManagerEntity *entityDemo = [self.arr_customer objectAtIndex:indexPath.row];
    CustomerShopInformationViewController *vc = [[CustomerShopInformationViewController alloc]init];
    vc.entity = entityDemo;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)searchBarAction{
    SearchCustomerViewController *vc = [[SearchCustomerViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
