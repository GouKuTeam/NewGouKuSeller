//
//  PayInGouKuViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PayInGouKuViewController.h"
#import "IQKeyboardManager.h"
#import "PayWaitView.h"
#import "CashierHandler.h"
#import "PayInCashCompleteView.h"

@interface PayInGouKuViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)PayWaitView      *v_wait;
@property (nonatomic ,strong)UITextField      *tf_tiaoxingma;
@property (nonatomic ,strong)NSString         *str_openId;

@property (nonatomic ,strong)PayInCashCompleteView      *v_cashComplete;

@end

@implementation PayInGouKuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购酷支付";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NocatifioncashcompleteAction) name:@"cashcomplete" object:nil];
}
-(void)onCreate{
    self.v_wait = [[PayWaitView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.v_wait] ;
    [self.v_wait.btn_back addTarget:self action:@selector(btn_backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tf_tiaoxingma = [[UITextField alloc]initWithFrame:CGRectMake(-500, 10 + SafeAreaTopHeight, SCREEN_WIDTH - 20, 32)];
    [self.view addSubview:self.tf_tiaoxingma];
    [self.tf_tiaoxingma setBackgroundColor:[UIColor clearColor]];
    [self.tf_tiaoxingma becomeFirstResponder];
    self.tf_tiaoxingma.delegate = self;
 
    self.v_cashComplete = [[PayInCashCompleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.v_cashComplete.btn_continueShou addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_cashComplete.lab_shifu setText:@"收款成功"];
    [self.v_cashComplete.lab_zhaoling setText:@""];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.v_cashComplete];
    [self.v_cashComplete setHidden:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    
    self.str_openId = textField.text;
    [self postUserScanCode];
    return YES;
}

-(void)postUserScanCode{
    [CashierHandler scanUserCashCodeWithOpenId:self.str_openId orderId:self.orderId prepare:^{
        
    } success:^(id obj) {
        [self.v_wait.img setImage:[UIImage imageNamed:@"wait"]];
        [self.v_wait.lab setText:@"扫描成功，等待支付"];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
}

- (void)NocatifioncashcompleteAction{
    [self.v_wait setHidden:YES];
    [self.v_cashComplete setHidden:NO];
}

- (void)btn_backAction{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ClearShoppingCar" object:nil userInfo:nil];
    [self.v_wait setHidden:YES];
    [self.v_wait removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)continueAction{
    //收款完成  发送通知  回到购物车页面  并清空购物车
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ClearShoppingCar" object:nil userInfo:nil];
    [self.v_cashComplete setHidden:YES];
    [self.v_cashComplete removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
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
