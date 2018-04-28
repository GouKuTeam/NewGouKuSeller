//
//  BankCardDetailViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BankCardDetailViewController.h"
#import "BankCardTableViewCell.h"
#import "BankCardInformationViewController.h"
@interface BankCardDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView        *tb_bank;

@end

@implementation BankCardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定银行卡";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"更换" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    self.tb_bank = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 44*6) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_bank];
    self.tb_bank.delegate = self;
    self.tb_bank.dataSource = self;
    self.tb_bank.rowHeight = 44;
    self.tb_bank.scrollEnabled = NO;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"TableViewCell";
    BankCardTableViewCell *cell = (BankCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[BankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.tf_detail.enabled = NO;
    if (indexPath.row == 0) {
        cell.lab_title.text = @"已绑定银行卡";
    }
    if (indexPath.row == 1) {
        cell.lab_title.text = @"开户名称";
        cell.tf_detail.text = self.entity.accountName;
    }
    if (indexPath.row == 2) {
        cell.lab_title.text = @"卡号";
        cell.tf_detail.text = [NSString stringWithFormat:@"%@",self.entity.cardNum];
    }
    if (indexPath.row == 3) {
        cell.lab_title.text = @"开户银行";
        cell.tf_detail.text = self.entity.bankName;
    }
    if (indexPath.row == 4) {
        cell.lab_title.text = @"开户地区";
        cell.tf_detail.text = self.entity.place;
    }
    if (indexPath.row == 5) {
        cell.lab_title.text = @"开户支行";
        cell.tf_detail.text = self.entity.bankBranch;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)rightBarAction{
    BankCardInformationViewController *vc = [[BankCardInformationViewController alloc]init];
    vc.enterFromType = EnterFromCard;
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
