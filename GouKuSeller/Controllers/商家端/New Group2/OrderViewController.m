//
//  OrderViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderHandler.h"
#import "OrderListTableViewCell.h"
#import "OrderListEntity.h"
#import "DateUtils.h"
#import "OrderDetailViewController.h"
#import "SearchOrderViewController.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>
@property (nonatomic ,strong)BaseTableView         *tb_order;
@property (nonatomic ,strong)NSMutableArray        *arr_order;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"订单";
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(searchBarAction)];
    [btn_right setImage:[UIImage imageNamed:@"home_search"]];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_order = [[NSMutableArray alloc]init];
    }
    return self;
}


- (void)onCreate{
    self.tb_order = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain hasHeaderRefreshing:YES hasFooterRefreshing:YES];
    [self.view addSubview:self.tb_order];
    [self.tb_order setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    self.tb_order.delegate = self;
    self.tb_order.dataSource = self;
    self.tb_order.tableViewDelegate = self;
    self.tb_order.tableFooterView = [UIView new];
    [self.tb_order requestDataSource];

}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [OrderHandler getOrderListWithShopId:[LoginStorage GetShopId] page:(int)pageNum prepare:^{
        
    } success:^(id obj) {
        if (pageNum == 0) {
            [self.arr_order removeAllObjects];
        }
        [self.arr_order addObjectsFromArray:(NSArray *)obj];
        [self.tb_order reloadData];
        complete([(NSArray *)obj count]);
        if (self.arr_order.count == 0) {
            self.tb_order.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tb_order.frame withDefaultImage:nil withNoteTitle:@"暂无数据" withNoteDetail:nil withButtonAction:nil];
        }
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 41;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr_order.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OrderListEntity *entity = [self.arr_order objectAtIndex:section];
    return entity.orderList.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderListEntity *entity = [self.arr_order objectAtIndex:section];
    UIView *v_section = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
    [v_section setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, 200, 41)];
    [v_section addSubview:lab];
    [lab setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [lab setFont:[UIFont systemFontOfSize:14]];
    lab.text = [DateUtils orderStringFromTimeInterval:entity.payDate];
    return v_section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"OrderListTableViewCell";
    OrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    OrderListEntity *entity = [self.arr_order objectAtIndex:indexPath.section];
    OrderDetailEntity *detailEntity = [entity.orderList objectAtIndex:indexPath.row];
    [cell contentCellWithOrderListEntity:detailEntity];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderListEntity *entity = [self.arr_order objectAtIndex:indexPath.section];
    OrderDetailEntity *detailEntity = [entity.orderList objectAtIndex:indexPath.row];
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
    vc.orderId = detailEntity.orderId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBarAction{
    SearchOrderViewController *vc = [[SearchOrderViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
