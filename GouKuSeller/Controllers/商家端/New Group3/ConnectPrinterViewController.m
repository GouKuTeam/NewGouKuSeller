//
//  ConnectPrinterViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ConnectPrinterViewController.h"
#import "JWBluetoothManage.h"
#import "SelectPrinterTableViewCell.h"
#import "PrinterSettingViewController.h"

#define WeakSelf __block __weak typeof(self)weakSelf = self;
@interface ConnectPrinterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    JWBluetoothManage * manage;
}

@property (nonatomic ,strong)UIView      *tb_header;
@property (nonatomic ,strong)UITableView     *tb_printer;
@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic ,strong)UIView      *v_notLanya;
@end

@implementation ConnectPrinterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"连接蓝牙打印机";
    
    self.dataSource = @[].mutableCopy;
    manage = [JWBluetoothManage sharedInstance];
    WeakSelf
    [manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *printeChatactersArray, NSArray<NSNumber *> *rssis) {
        [self.v_notLanya setHidden:YES];
        [self.tb_printer setHidden:NO];
        weakSelf.dataSource = [NSMutableArray arrayWithArray:printeChatactersArray];
        [weakSelf.tb_printer reloadData];
    } failure:^(CBManagerState status) {

        if (status == CBManagerStatePoweredOff) {
            [self.v_notLanya setHidden:NO];
            [self.tb_printer setHidden:YES];
        }else{
           [ProgressShow alertView:self.view Message:[ProgressShow getBluetoothErrorInfo:status] cb:nil];
            [self.v_notLanya setHidden:YES];
            [self.tb_printer setHidden:NO];
        }
    }];
    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
        weakSelf.title = @"连接蓝牙打印机";
    };
}

- (void)onCreate{
    self.tb_header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 16, 100, 20)];
    [lab setText:@"选择设备"];
    [lab setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [lab setFont:[UIFont systemFontOfSize:14]];
    [self.tb_header addSubview:lab];
    
    self.tb_printer = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tb_printer];
    self.tb_printer.delegate = self;
    self.tb_printer.dataSource = self;
    self.tb_printer.rowHeight = 44;
    self.tb_printer.tableHeaderView = self.tb_header;
    self.tb_printer.tableFooterView = [UIView new];
    [self.tb_printer setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    
    self.v_notLanya = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 160)];
    [self.view addSubview:self.v_notLanya];
    [self.v_notLanya setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 20)];
    [self.v_notLanya addSubview:lb1];
    [lb1 setText:@"蓝牙功能未开启"];
    [lb1 setTextColor:[UIColor blackColor]];
    [lb1 setFont:[UIFont boldSystemFontOfSize:18]];
    [lb1 setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, lb1.bottom + 30, SCREEN_WIDTH, 20)];
    [self.v_notLanya addSubview:lb2];
    [lb2 setText:@"请在手机设置中开启蓝牙"];
    [lb2 setTextColor:[UIColor blackColor]];
    [lb2 setFont:[UIFont systemFontOfSize:18]];
    [lb2 setTextAlignment:NSTextAlignmentCenter];
    
    [self.v_notLanya setHidden:YES];
    
}

#pragma mark tableview medthod
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    SelectPrinterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SelectPrinterTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    CBPeripheral *peripherral = [self.dataSource objectAtIndex:indexPath.row];
//    if (peripherral.state == CBPeripheralStateConnected) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    cell.lab_printerName.text = [NSString stringWithFormat:@"%@",peripherral.name];
    cell.btn_connectPrinter.tag = indexPath.row;
    [cell.btn_connectPrinter addTarget:self action:@selector(btn_connectPrinterAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CBPeripheral *peripheral = [self.dataSource objectAtIndex:indexPath.row];
    [manage connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {

            PrinterSettingViewController *vc = [[PrinterSettingViewController alloc]init];
            vc.printerName = perpheral.name;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)btn_connectPrinterAction:(UIButton *)sender{
    CBPeripheral *peripheral = [self.dataSource objectAtIndex:sender.tag];
    [manage connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            PrinterSettingViewController *vc = [[PrinterSettingViewController alloc]init];
            vc.printerName = perpheral.name;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
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
