//
//  PrinterSettingViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PrinterSettingViewController.h"
#import "JWBluetoothManage.h"

@interface PrinterSettingViewController (){
    JWBluetoothManage * manage;
}

@property (nonatomic ,strong)UISwitch                 *v_switch;


@end

@implementation PrinterSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"打印机设置";
    manage = [JWBluetoothManage sharedInstance];
}

- (void)onCreate{
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 160)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *img_printer = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 40) / 2, 37, 40, 40)];
    [v_back addSubview:img_printer];
    [img_printer setImage:[UIImage imageNamed:@"printer"]];
    
    UILabel *lab_printer = [[UILabel alloc]initWithFrame:CGRectMake(0, img_printer.bottom + 7, SCREEN_WIDTH, 25)];
    [v_back addSubview:lab_printer];
    [lab_printer setText:self.printerName];
    [lab_printer setTextColor:[UIColor blackColor]];
    [lab_printer setTextAlignment:NSTextAlignmentCenter];
    [lab_printer setFont:[UIFont boldSystemFontOfSize:18]];
    
    UIButton *btn_connect = [[UIButton alloc]initWithFrame:CGRectMake(0, lab_printer.bottom + 5, SCREEN_WIDTH, 20)];
    [v_back addSubview:btn_connect];
    [btn_connect setTitle:@"已连接" forState:UIControlStateNormal];
    [btn_connect setTitleColor:[UIColor colorWithHexString:@"#329702"] forState:UIControlStateNormal];
    [btn_connect setImage:[UIImage imageNamed:@"right copy"] forState:UIControlStateNormal];
    [btn_connect setImageEdgeInsets:UIEdgeInsetsMake(0.0, -6, 0.0, 0.0)];
    btn_connect.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    btn_connect.enabled = NO;
    
    UIView *v_mid = [[UIView alloc]initWithFrame:CGRectMake(0, v_back.bottom + 20, SCREEN_WIDTH, 88)];
    [self.view addSubview:v_mid];
    [v_mid setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab_1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
    [v_mid addSubview:lab_1];
    [lab_1 setText:@"自动打印小票"];
    [lab_1 setTextColor: [UIColor blackColor]];
    [lab_1 setFont:[UIFont systemFontOfSize:16]];
    
    self.v_switch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 0, 51, 31)];
    [v_mid addSubview:self.v_switch];
    [self.v_switch setOnTintColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
    self.v_switch.layer.anchorPoint = CGPointMake(0, 0.3);
    [self.v_switch setOn:YES animated:true];
    [self.v_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    UIImageView *img_line = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, 0.5)];
    [v_mid addSubview:img_line];
    [img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    UILabel *lab_2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, 100, 44)];
    [v_mid addSubview:lab_2];
    [lab_2 setText:@"打印联数"];
    [lab_2 setTextColor: [UIColor blackColor]];
    [lab_2 setFont:[UIFont systemFontOfSize:16]];
    
    UIButton *btn_dayin = [[UIButton alloc]initWithFrame:CGRectMake(0, v_mid.bottom + 20, SCREEN_WIDTH, 44)];
    [self.view addSubview:btn_dayin];
    [btn_dayin setTitle:@"打印测试页" forState:UIControlStateNormal];
    btn_dayin.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_dayin setBackgroundColor:[UIColor whiteColor]];
    [btn_dayin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_dayin addTarget:self action:@selector(btn_dayinAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn_duankai = [[UIButton alloc]initWithFrame:CGRectMake(0, btn_dayin.bottom + 20, SCREEN_WIDTH, 44)];
    [self.view addSubview:btn_duankai];
    [btn_duankai setTitle:@"断开连接" forState:UIControlStateNormal];
    btn_duankai.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn_duankai setBackgroundColor:[UIColor whiteColor]];
    [btn_duankai setTitleColor:[UIColor colorWithHexString:@"#D0021B"] forState:UIControlStateNormal];
    [btn_duankai addTarget:self action:@selector(btn_duankaiAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btn_dayinAction{
    if (manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"********饿了么#18********";
    [printer appendText:str1 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
    NSString *str2 = @"购酷测试餐厅1";
    [printer appendText:str2 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    NSString *str3 = @"--已在线支付--";
    [printer appendText:str3 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];
    NSString *str4 = @"---------------------";
    [printer appendText:str4 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];
    NSString *str5 = @"下单时间：05-17 16：21";
    [printer appendText:str5 alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    NSString *str6 = @"备注：爱吃辣多点辣";
    [printer appendText:str6 alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleMiddle];
    NSString *str7 = @"发票：扎拉斯网络科技(上海有限公司)";
    [printer appendText:str7 alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleMiddle];
    NSString *str8 = @"-----------商品-----------";
    [printer appendText:str8 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleSmalle];
    [printer appendLeftText:@"米饭" middleText:@"x2" rightText:@"4" isTitle:NO];
    [printer appendTitle:@"商户名称：" value:@"永和大豆浆"];
    [printer appendTitle:@"商户编号：" value:@"1234567890"];
    [printer appendTitle:@"订单编号：" value:@"MS1234567890"];
    [printer appendTitle:@"交易类型：" value:@"微信支付"];
    [printer appendTitle:@"交易时间：" value:@"2017-06-14"];
    [printer appendTitle:@"金    额：" value:@"1000元"];
    [printer appendFooter:@"欢迎使用银智付!"];
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}

- (void)btn_duankaiAction{
    [manage cancelPeripheralConnection:manage.connectedPerpheral];
    [MBProgressHUD showInfoMessage:@"打印机已断开"];
    [self performSelector:@selector(gobackToConnectPrinter) withObject:nil afterDelay:1];
}

- (void)gobackToConnectPrinter{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchAction:(id)sender{
    if (self.v_switch.on == YES) {
        [LoginStorage saveIsPrinter:YES];
    } else {
        [LoginStorage saveIsPrinter:NO];
    }
}

- (void)leftBarAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
