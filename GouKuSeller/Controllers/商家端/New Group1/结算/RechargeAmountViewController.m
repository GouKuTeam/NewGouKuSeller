//
//  RechargeAmountViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "RechargeAmountViewController.h"
#import "SettlementHandler.h"
#import <WXApi.h>
#import "WXApiManager.h"
#import "PayInCashCompleteView.h"


@interface RechargeAmountViewController ()<UITextFieldDelegate,WXApiManagerDelegate>
@property (nonatomic ,strong)UITextField      *tf_price;
@property (nonatomic ,strong)UIButton         *btn_chongzhi;
@property (nonatomic ,strong)PayInCashCompleteView      *v_cashComplete;

@property (nonatomic ,assign)int          int_userName;     // =1 有内容   =0没内容

@end

@implementation RechargeAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    [WXApiManager sharedManager].delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPaySuccess) name:NF_WECHAT_PAY_SUCCESS object:nil];
}

- (void)onCreate{
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 255)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 24, 80, 22)];
    [v_back addSubview:lab1];
    [lab1 setText:@"充值金额"];
    [lab1 setTextColor:[UIColor blackColor]];
    [lab1 setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *lab_imgPrice = [[UILabel alloc]initWithFrame:CGRectMake(15, lab1.bottom + 26, 30, 67)];
    [v_back addSubview:lab_imgPrice];
    [lab_imgPrice setText:@"¥"];
    lab_imgPrice.font = [UIFont systemFontOfSize:48];
    [lab_imgPrice setTextColor:[UIColor blackColor]];
    
    self.tf_price = [[UITextField alloc]initWithFrame:CGRectMake(lab_imgPrice.right + 20, lab1.bottom + 26, 200, 67)];
    [v_back addSubview:self.tf_price];
    [self.tf_price setTextColor:[UIColor blackColor]];
    [self.tf_price setFont:[UIFont systemFontOfSize:48]];
    self.tf_price.keyboardType = UIKeyboardTypeDecimalPad;
    self.tf_price.delegate = self;
    
    UIImageView *img_line = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.tf_price.bottom + 12.3, SCREEN_WIDTH - 30, 0.5)];
    [v_back addSubview:img_line];
    [img_line setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, img_line.bottom + 38.7, 80, 22)];
    [v_back addSubview:lab2];
    [lab2 setText:@"支付方式"];
    [lab2 setTextColor:[UIColor blackColor]];
    [lab2 setFont:[UIFont systemFontOfSize:16]];
    
    UIButton *btn_weixin = [[UIButton alloc]initWithFrame:CGRectMake(99, img_line.bottom + 30, 110, 40)];
    [v_back addSubview:btn_weixin];
    [btn_weixin setTitle:@"微信" forState:UIControlStateNormal];
    [btn_weixin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_weixin.titleLabel.font = [UIFont systemFontOfSize:16];
    btn_weixin.layer.cornerRadius = 2.0f;
    btn_weixin.layer.borderWidth = 1.0f;
    btn_weixin.layer.borderColor = [[UIColor colorWithHexString:@"#4167B2"] CGColor];
    [btn_weixin setImage:[UIImage imageNamed:@"weixinpaygreen"] forState:UIControlStateNormal];
    [btn_weixin setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15, 0.0, 0.0)];
    
    self.btn_chongzhi = [[UIButton alloc]initWithFrame:CGRectMake(15, v_back.bottom + 27, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:self.btn_chongzhi];
    [self.btn_chongzhi setTitle:@"充值" forState:UIControlStateNormal];
    self.btn_chongzhi.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.btn_chongzhi setBackgroundColor:[UIColor colorWithHexString:@"#5D84D1"]];
    [self.btn_chongzhi setTitleColor:[UIColor colorWithHexString:@"#C7DEF2"] forState:UIControlStateNormal];
    self.btn_chongzhi.layer.cornerRadius = 3.0f;
    self.btn_chongzhi.enabled = NO;
    [self.btn_chongzhi addTarget:self action:@selector(btn_chongzhiAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.v_cashComplete = [[PayInCashCompleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.v_cashComplete.btn_continueShou addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_cashComplete.btn_continueShou setTitle:@"充值成功" forState:UIControlStateNormal];
    [self.v_cashComplete.lab_shifu setText:@"充值成功"];
    [self.v_cashComplete.lab_shifu setFont:[UIFont systemFontOfSize:20]];
    [self.v_cashComplete.lab_zhaoling setFont:[UIFont boldSystemFontOfSize:36]];
    [self.v_cashComplete.lab_zhaoling setText:[NSString stringWithFormat:@"¥%.2f",[self.tf_price.text doubleValue]]];
    [[[UIApplication  sharedApplication]keyWindow]addSubview:self.v_cashComplete];
    [self.v_cashComplete setHidden:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.tf_price) {
        double value = [self.tf_price.text doubleValue];
        if (value > 0) {
            [self.btn_chongzhi setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
            [self.btn_chongzhi setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
            [self.tf_price setText:[NSString stringWithFormat:@"%.2f",[textField.text doubleValue]]];
            self.btn_chongzhi.enabled = YES;
            return;
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tf_price) {
        NSMutableString * changedString=[[NSMutableString alloc]initWithString:textField.text];
        [changedString replaceCharactersInRange:range withString:string];
        if (changedString.length!=0) {
            NSLog(@"用户名有内容");
            self.int_userName = 1;
        }else{
            NSLog(@"用户名没内容");
            self.int_userName = 0;
        }
    }
    if (self.int_userName == 1) {
        [self.btn_chongzhi setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
        [self.btn_chongzhi setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        self.btn_chongzhi.enabled = YES;
    }else{
        [self.btn_chongzhi setBackgroundColor:[UIColor colorWithHexString:@"#5D84D1"]];
        [self.btn_chongzhi setTitleColor:[UIColor colorWithHexString:@"#C7DEF2"] forState:UIControlStateNormal];
        self.btn_chongzhi.enabled = NO;
    }
    return YES;
}

- (void)btn_chongzhiAction{
    [self.tf_price resignFirstResponder];
//    if ([WXApi isWXAppInstalled]) {
//        [SettlementHandler weixinchongzhiWithPrice:[NSString stringWithFormat:@"%.2f",[self.tf_price.text doubleValue]] prepare:^{
//
//        } success:^(id obj) {
//            NSDictionary *dic = (NSDictionary *)obj;
//            [self weiXinPayWithDic:dic];
//        } failed:^(NSInteger statusCode, id json) {
//            [MBProgressHUD showErrorMessage:(NSString *)json];
//        }];
//    }else{
//        [MBProgressHUD showInfoMessage:@"请安装微信"];
//    }
    [SettlementHandler weixinchongzhiWithPrice:[NSString stringWithFormat:@"%.2f",[self.tf_price.text doubleValue]] prepare:^{
        
    } success:^(id obj) {
        if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
            [self weiXinPayWithDic:[(NSDictionary *)obj objectForKey:@"data"]];
        }else{
            [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
        }
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
    
}

- (void)weiXinPayWithDic:(NSDictionary *)wechatPayDic {
    PayReq *req = [[PayReq alloc] init];
//    req.openID = [wechatPayDic objectForKey:@"appid"];
    req.partnerId = [wechatPayDic objectForKey:@"partnerid"];
    req.prepayId = [wechatPayDic objectForKey:@"prepayid"];
    req.package = [wechatPayDic objectForKey:@"packagee"];
    req.nonceStr = [wechatPayDic objectForKey:@"nonceStr"];
    req.timeStamp = [[wechatPayDic objectForKey:@"timeStamp"] intValue];
    req.sign = [wechatPayDic objectForKey:@"sign"];
    [WXApi sendReq:req];
    
}

- (void)weChatPaySuccess{
    [self.v_cashComplete.lab_zhaoling setText:[NSString stringWithFormat:@"¥%.2f",[self.tf_price.text doubleValue]]];
    [self.v_cashComplete setHidden:NO];
}


- (void)continueAction{
    [self.v_cashComplete setHidden:YES];
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
