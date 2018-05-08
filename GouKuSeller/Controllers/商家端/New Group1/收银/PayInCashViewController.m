//
//  PayInCashViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PayInCashViewController.h"
#import "PayInCashCompleteView.h"
#import "OttoKeyboardView.h"


@interface PayInCashViewController ()

@property (nonatomic ,strong)OttoTextField     *tf_price;
@property (nonatomic ,strong)PayInCashCompleteView      *v_cashComplete;

@end

@implementation PayInCashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现金支付";
}

- (void)onCreate{
    
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 20, SCREEN_WIDTH, 100)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab_heji = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 50)];
    [v_back addSubview:lab_heji];
    [lab_heji setText:@"合计"];
    [lab_heji setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab_heji setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *lab_totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, SCREEN_WIDTH - 150 - 10, 50)];
    [v_back addSubview:lab_totalPrice];
    [lab_totalPrice setText:[NSString stringWithFormat:@"¥%.2f",self.totalPrice]];
    [lab_totalPrice setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab_totalPrice setFont:[UIFont systemFontOfSize:16]];
    [lab_totalPrice setTextAlignment:NSTextAlignmentRight];
    
    UIImageView *imgheng = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49.5, SCREEN_WIDTH - 10, 0.5)];
    [v_back addSubview:imgheng];
    [imgheng setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    UILabel *lab_zhifu = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 100, 50)];
    [v_back addSubview:lab_zhifu];
    [lab_zhifu setText:@"实付金额"];
    [lab_zhifu setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab_zhifu setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_price = [[OttoTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 50, 90, 50)];
    [v_back addSubview:self.tf_price];
    [self.tf_price setPlaceholder:[NSString stringWithFormat:@"¥%.2f",self.totalPrice]];
    [self.tf_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.tf_price setFont:[UIFont systemFontOfSize:16]];
    [self.tf_price setTextAlignment:NSTextAlignmentRight];
    [self.tf_price becomeFirstResponder];
    [self.tf_price setKeyboardType:KeyboardTypeNumber];
    [self.tf_price setNumberKeyboardType:NumberKeyboardTypeDouble];
    
    UIButton *btn_shoukuan = [[UIButton alloc]initWithFrame:CGRectMake(15, 141 + SafeAreaTopHeight, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:btn_shoukuan];
    [btn_shoukuan setTitle:@"收款" forState:UIControlStateNormal];
    [btn_shoukuan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_shoukuan setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
    btn_shoukuan.layer.cornerRadius = 3.0f;
    btn_shoukuan.layer.masksToBounds = YES;
    [btn_shoukuan addTarget:self action:@selector(btnshoukuanAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)btnshoukuanAction{
    
    if ([self.tf_price.text isEqualToString:@""]) {
        [self.tf_price resignFirstResponder];
        self.v_cashComplete = [[PayInCashCompleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.v_cashComplete.btn_continueShou addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
        [self.v_cashComplete.lab_shifu setText:[NSString stringWithFormat:@"实付：¥%.2f",self.totalPrice]];
        [self.v_cashComplete.lab_zhaoling setText:[NSString stringWithFormat:@"找零：¥0.00"]];
        [[[UIApplication  sharedApplication]keyWindow]addSubview:self.v_cashComplete];
    }else{
        
        [self.tf_price resignFirstResponder];
        self.v_cashComplete = [[PayInCashCompleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.v_cashComplete.btn_continueShou addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
        [self.v_cashComplete.lab_shifu setText:[NSString stringWithFormat:@"实付：¥%.2f",self.totalPrice]];
        [self.v_cashComplete.lab_zhaoling setText:[NSString stringWithFormat:@"找零：¥%.2f",  [self.tf_price.text doubleValue] - self.totalPrice]];
        [[[UIApplication  sharedApplication]keyWindow]addSubview:self.v_cashComplete] ;
    }
}

- (void)continueAction{
    //收款完成  发送通知  回到购物车页面  并清空购物车
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ClearShoppingCar" object:nil userInfo:nil];
    [self.v_cashComplete removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
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
