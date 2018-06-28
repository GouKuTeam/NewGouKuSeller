//
//  EleMeBillDetailViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EleMeBillDetailViewController.h"
#import "EleMeBillHeaderView.h"
#import "EleMeBillTableViewCell.h"
#import "SettlementHandler.h"

@interface EleMeBillDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelagate>

@property (nonatomic ,strong)EleMeBillHeaderView       *v_header;
@property (nonatomic ,strong)BaseTableView             *tb_bill;
@property (nonatomic ,strong)NSMutableArray            *arr_bill;

@end

@implementation EleMeBillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_bill = [NSMutableArray array];
    }
    return self;
}

- (void)onCreate{
    self.v_header = [[EleMeBillHeaderView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 275)];
    [self.v_header contentEleMeBillHeaderViewWithDic:nil];
    
    UIView *v_footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 24)];
    [v_footer setBackgroundColor:[UIColor clearColor]];
    UILabel *lab_t = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 17)];
    [v_footer addSubview:lab_t];
    [lab_t setText:@"没有更多了"];
    [lab_t setFont:[UIFont systemFontOfSize:12]];
    [lab_t setTextAlignment:NSTextAlignmentCenter];
    [lab_t setTextColor:[UIColor colorWithHexString:@"#9B9B9B"]];
    
    self.tb_bill = [[BaseTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain hasHeaderRefreshing:NO hasFooterRefreshing:YES];
    [self.view addSubview:self.tb_bill];
    self.tb_bill.delegate = self;
    self.tb_bill.dataSource = self;
    self.tb_bill.tableViewDelegate = self;
    self.tb_bill.tableHeaderView = self.v_header;
    self.tb_bill.tableFooterView = v_footer;
    self.tb_bill.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tb_bill setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [self.tb_bill requestDataSource];
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    
    [SettlementHandler outOrderDetailWithPlatform:2 date:self.accountentity.timestamp page:(int)pageNum prepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = [(NSDictionary *)obj objectForKey:@"data"];
        self.title = [NSString stringWithFormat:@"%@ 账单",[dic objectForKey:@"date"]];
        [self.v_header contentEleMeBillHeaderViewWithDic:dic];
        
        if (pageNum == 0) {
            [self.arr_bill removeAllObjects];
        }
        [self.arr_bill addObjectsFromArray:[dic objectForKey:@"orderList"]];
        if (self.arr_bill.count < 21) {
            self.tb_bill.hasFooterRefreshing = NO;
        }else{
            self.tb_bill.hasFooterRefreshing = YES;
        }
        [self.tb_bill reloadData];
        complete([(NSArray *)obj count]);
    } failed:^(NSInteger statusCode, id json) {
        if (complete) {
            complete(CompleteBlockErrorCode);
        }
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_bill.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"EleMeBillTableViewCell";
    EleMeBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[EleMeBillTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    NSDictionary *dic = [self.arr_bill objectAtIndex:indexPath.row];
    [cell.lab_xuhao setText:[dic objectForKey:@"outId"]];
    if ([[dic objectForKey:@"status"] intValue] == 1) {
        [cell.lab_status setText:@"完成"];
        [cell.lab_price setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]]];
    }else{
        [cell.lab_status setText:@"退款"];
        [cell.lab_price setText:[NSString stringWithFormat:@"-%@",[dic objectForKey:@"money"]]];
    }
    
    return cell;
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
