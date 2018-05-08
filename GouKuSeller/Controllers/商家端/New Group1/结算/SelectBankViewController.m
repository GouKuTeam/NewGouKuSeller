//
//  SelectBankViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/28.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectBankViewController.h"
#import "SettlementHandler.h"

@interface SelectBankViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic ,strong)UITableView             *tb_bank;
@property (nonatomic ,strong)NSMutableArray          *arr_bank;

@end

@implementation SelectBankViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arr_bank = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择开户银行";
    // Do any additional setup after loading the view.
}

- (void)onCreate{
    self.tb_bank = [[UITableView alloc]initWithFrame:CGRectMake(0, 10 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - 10) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_bank];
    self.tb_bank.delegate = self;
    self.tb_bank.dataSource = self;
    [self.tb_bank setRowHeight:44];
    self.tb_bank.tableFooterView = [UIView new];
    [self.tb_bank setBackgroundColor:[UIColor clearColor]];
    [self loadData];
}

- (void)loadData{
    [SettlementHandler getbankListprepare:^{
        
    } success:^(id obj) {
        [self.arr_bank addObjectsFromArray:(NSArray *)obj];
        [self.tb_bank reloadData];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr_bank.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"BankCardTableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[[self.arr_bank objectAtIndex:indexPath.row] objectForKey:@"bankName"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *bankName = [[self.arr_bank objectAtIndex:indexPath.row] objectForKey:@"bankName"];
    if (self.goBack) {
        self.goBack(bankName);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
