//
//  TiXianiewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/29.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "TiXianiewController.h"
#import "TiXianView.h"
#import "PasswordAlertView.h"
#import "SettlementHandler.h"
#import "FindPwWithUserNameViewController.h"
@interface TiXianiewController ()<UITextFieldDelegate,PasswordAlertViewDelegate>

@property (nonatomic ,strong)TiXianView       *v_tixian;
@property (nonatomic ,strong)UIButton         *btn_tixian;
@property (nonatomic ,assign)int               int_userName;     // =1 有内容   =0没内容

@end

@implementation TiXianiewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    
}

-(void)onCreate{
    self.v_tixian = [[TiXianView alloc]initWithFrame:CGRectMake(0, 10 + SafeAreaTopHeight, SCREEN_WIDTH, 285)];
    [self.view addSubview:self.v_tixian];
    self.v_tixian.tf_price.delegate = self;
    NSString *str_cardNum = [self.cardNum substringFromIndex:self.cardNum.length - 4];
    [self.v_tixian.lab_bankNum setText:[NSString stringWithFormat:@"%@(%@)",self.cardName,str_cardNum]];
    [self.v_tixian.lab_ketixian setText:[NSString stringWithFormat:@"可提现金额¥%.2f",self.ketixianPrice]];
    [self.v_tixian.lab_tixiancount setText:[NSString stringWithFormat:@"今日可提现%d次",self.tixianCount]];
    
    [self.v_tixian.btn_tianxianAll addTarget:self action:@selector(btn_tianxianAll) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_tixian = [[UIButton alloc]initWithFrame:CGRectMake(15, 325 + SafeAreaTopHeight, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:self.btn_tixian];
    [self.btn_tixian setTitle:@"提现" forState:UIControlStateNormal];
    [self.btn_tixian addTarget:self action:@selector(btn_tixianAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_tixian setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn_tixian setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
    self.btn_tixian.titleLabel.font = [UIFont systemFontOfSize:18];
    self.btn_tixian.layer.cornerRadius = 3.0f;
    self.btn_tixian.layer.masksToBounds = YES;
    self.btn_tixian.enabled = NO;
    if (self.tixianCount == 0) {
        [self.btn_tixian setTitle:@"今日提现次数已用完" forState:UIControlStateNormal];
        [self.btn_tixian setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        [self.btn_tixian setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.v_tixian.tf_price.enabled = NO;
    }
}

- (void)btn_tixianAction{
    double value = [self.v_tixian.tf_price.text doubleValue];
    if (value > self.ketixianPrice) {
        //输入金额大于可提现金额
        [MBProgressHUD showInfoMessage:@"输入金额大于可提现金额"];
        self.v_tixian.tf_price.text = @"";
        [self.btn_tixian setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
        [self.btn_tixian setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
        self.btn_tixian.enabled = NO;
        return;
    }
    else if (value < self.lowPrice) {
        //输入金额小于最低提现金额
        [MBProgressHUD showInfoMessage:@"输入金额小于最低提现金额"];
        self.v_tixian.tf_price.text = @"";
        [self.btn_tixian setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
        [self.btn_tixian setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
        self.btn_tixian.enabled = NO;
        return;
    }else{
        
        PasswordAlertView *view = [[PasswordAlertView alloc]initWithPrice:[self.v_tixian.tf_price.text doubleValue] title:@"提现" delegate:self];
        [view show];
    }
}

- (void)btn_tianxianAll{
    if (self.tixianCount < 1) {
        
    }else{
        self.v_tixian.tf_price.text = [NSString stringWithFormat:@"%.2f",self.ketixianPrice];
        [self.btn_tixian setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [self.btn_tixian setBackgroundColor:[UIColor colorWithHexString:@"#4167b2"]];
        self.btn_tixian.enabled = YES;
    }
}

#pragma UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField == self.v_tixian.tf_price) {
//        double value = [self.v_tixian.tf_price.text doubleValue];
//        if (value > self.ketixianPrice) {
//            //输入金额大于可提现金额
//            [MBProgressHUD showInfoMessage:@"输入金额大于可提现金额"];
//            self.v_tixian.tf_price.text = @"";
//            [self.btn_tixian setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
//            [self.btn_tixian setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
//            self.btn_tixian.enabled = NO;
//            return;
//        }
//        if (value < self.lowPrice) {
//            //输入金额小于最低提现金额
//            [MBProgressHUD showInfoMessage:@"输入金额小于最低提现金额"];
//            self.v_tixian.tf_price.text = @"";
//            [self.btn_tixian setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
//            [self.btn_tixian setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
//            self.btn_tixian.enabled = NO;
//            return;
//        }
//        if (![textField.text isEqualToString:@""]) {
//            [self.v_tixian.tf_price setText:[NSString stringWithFormat:@"%.2f",[textField.text floatValue]]];
//            self.btn_tixian.enabled = YES;
//        }
//    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.v_tixian.tf_price) {
        
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
        [self.btn_tixian setBackgroundColor:[UIColor colorWithRed:65/255.0 green:103/255.0 blue:178/255.0 alpha:1]];
        [self.btn_tixian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_tixian.enabled = YES;
    }else{
        [self.btn_tixian setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
        [self.btn_tixian setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
        self.btn_tixian.enabled = NO;
    }
    
    return YES;
}
#pragma PasswordDelegate
- (void)alertView:(PasswordAlertView *)alertView buttonType:(PasswordAlertBtnType)btnType passwordStr:(NSString *)password{
    if (btnType == PasswordAlertBtnConfirm) {
        [SettlementHandler checkPassWordWithshopId:[LoginStorage GetShopId] cardNum:self.cardNum money:[self.v_tixian.tf_price.text doubleValue] username:[LoginStorage GetUserName] password:password prepare:^{
        } success:^(id obj) {
            if ([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 0) {
                [MBProgressHUD showInfoMessage:@"提现成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else if([[(NSDictionary *)obj objectForKey:@"errCode"] intValue] == 1){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误，请重试" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    FindPwWithUserNameViewController *vc = [[FindPwWithUserNameViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }];
                UIAlertAction *again = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    PasswordAlertView *view = [[PasswordAlertView alloc]initWithPrice:[self.v_tixian.tf_price.text doubleValue] title:@"提现" delegate:self];
                    [view show];
                }];
                [alert addAction:forgetPassword];
                [alert addAction:again];
                [self presentViewController:alert animated:YES completion:nil];

            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showErrorMessage:[(NSDictionary *)obj objectForKey:@"errMessage"]];
            }
        } failed:^(NSInteger statusCode, id json) {
            [MBProgressHUD showErrorMessage:(NSString *)json];
        }];
    }
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
