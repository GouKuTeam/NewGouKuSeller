//
//  PrinterManagerViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PrinterManagerViewController.h"
#import "ConnectPrinterViewController.h"
#import "JWBluetoothManage.h"
#import "PrinterSettingViewController.h"

#define WeakSelf __block __weak typeof(self)weakSelf = self;

@interface PrinterManagerViewController (){
    JWBluetoothManage * manage;
}

@property (nonatomic ,strong)UILabel      *lab_printer;

@end

@implementation PrinterManagerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
//            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
//            weakSelf.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
            [self.lab_printer setText:perpheral.name];
        }else{
            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"打印机管理";
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(printerDismissAction) name:@"printerDismiss" object:nil];
    manage = [JWBluetoothManage sharedInstance];
    
    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"printerDismiss" object:nil];
        
    };
}

- (void)onCreate{
    UILabel *lab_title = [[UILabel alloc]initWithFrame:CGRectMake(8, SafeAreaTopHeight + 20, SCREEN_WIDTH - 8, 20)];
    [self.view addSubview:lab_title];
    [lab_title setText:@"蓝牙打印机"];
    [lab_title setFont:[UIFont systemFontOfSize:14]];
    [lab_title setTextColor:[UIColor colorWithHexString:@"#616161"]];
    
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, lab_title.bottom + 8, SCREEN_WIDTH, 44)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor: [UIColor whiteColor]];
    UITapGestureRecognizer *tgp_vback = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tgp_vback)];
    [self.view addGestureRecognizer:tgp_vback];
    
    UILabel *lab_left = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 44)];
    [v_back addSubview:lab_left];
    [lab_left setText:@"蓝牙打印机"];
    [lab_left setFont:[UIFont systemFontOfSize:16]];
    [lab_left setTextColor:[UIColor colorWithHexString:@"#000000"]];
    
    UIImageView *img_arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 10, 12, 20, 20)];
    [v_back addSubview:img_arrow];
    [img_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
    
    self.lab_printer = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 33 - 100, 0, 100, 44)];
    [v_back addSubview:self.lab_printer];
    [self.lab_printer setFont:[UIFont systemFontOfSize:16]];
    [self.lab_printer setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [self.lab_printer setTextAlignment:NSTextAlignmentRight];
    [self.lab_printer setText:@"未连接"];
    
  
}

- (void)tgp_vback{
    if ([self.lab_printer.text isEqualToString:@"未连接"]) {
        ConnectPrinterViewController *vc = [[ConnectPrinterViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        PrinterSettingViewController *vc = [[PrinterSettingViewController alloc]init];
        vc.printerName = self.lab_printer.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)printerDismissAction{
    [self.lab_printer setText:@"未连接"];
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
