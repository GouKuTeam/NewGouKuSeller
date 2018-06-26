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

@interface EleMeBillDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)EleMeBillHeaderView       *v_header;
@property (nonatomic ,strong)UITableView               *tb_bill;

@end

@implementation EleMeBillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    self.tb_bill = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_bill];
    self.tb_bill.delegate = self;
    self.tb_bill.dataSource = self;
    self.tb_bill.tableHeaderView = self.v_header;
    self.tb_bill.tableFooterView = v_footer;
    self.tb_bill.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tb_bill setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"EleMeBillTableViewCell";
    EleMeBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[EleMeBillTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
//    AccountCashDetailEntity *entity = [self.arr_priceDetail objectAtIndex:indexPath.section];
//    [cell contentCellWithAccountCashDetailEntity:entity];
    
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
