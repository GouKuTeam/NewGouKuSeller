//
//  SetPassWordViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SetPassWordViewController.h"
#import "RTHttpClient.h"
#import "FindPwWithUserNameViewController.h"
#import "FindPwWithCodeViewController.h"
@interface SetPassWordViewController()<UITextFieldDelegate>

@property (nonatomic ,strong)UITextField         *tf_newCode;
@property (nonatomic ,strong)UITextField         *tf_sureCode;
@property (nonatomic ,strong)UIButton               *btn_next;
@property (nonatomic ,assign)int          int_userName;     // =1 有内容   =0没内容
@property (nonatomic ,assign)int          int_passWord;

@end

@implementation SetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
}

- (void)onCreate{
    UILabel *lab_newCode = [[UILabel alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 31, 64, 22 )];
    [self.view addSubview:lab_newCode];
    [lab_newCode setText:@"新密码"];
    [lab_newCode setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab_newCode setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_newCode = [[UITextField alloc]initWithFrame:CGRectMake(96, SafeAreaTopHeight + 31, SCREEN_WIDTH - 116, 22)];
    [self.view addSubview:self.tf_newCode];
    [self.tf_newCode setPlaceholder:@"6-15位数字/字母/字符的组合"];
    [self.tf_newCode setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.tf_newCode setFont:[UIFont systemFontOfSize:16]];
    self.tf_newCode.delegate = self;
    self.tf_newCode.secureTextEntry = YES;
    
    UIImageView *img_line1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 68, SCREEN_WIDTH - 15, 0.5)];
    [self.view addSubview:img_line1];
    [img_line1 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    
    ///
    UILabel *lab_sureCode = [[UILabel alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 81, 75, 22 )];
    [self.view addSubview:lab_sureCode];
    [lab_sureCode setText:@"确认密码"];
    [lab_sureCode setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab_sureCode setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_sureCode = [[UITextField alloc]initWithFrame:CGRectMake(96, SafeAreaTopHeight + 81, SCREEN_WIDTH - 116, 22)];
    [self.view addSubview:self.tf_sureCode];
    [self.tf_sureCode setPlaceholder:@"再输入一次密码"];
    [self.tf_sureCode setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.tf_sureCode setFont:[UIFont systemFontOfSize:16]];
    self.tf_sureCode.delegate = self;
    self.tf_sureCode.secureTextEntry = YES;
    
    UIImageView *img_line2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 118, SCREEN_WIDTH - 15, 0.5)];
    [self.view addSubview:img_line2];
    [img_line2 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    
    self.btn_next = [[UIButton alloc]init];
    [self.btn_next setFrame:CGRectMake(15, 143 + SafeAreaTopHeight, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:self.btn_next];
    [self.btn_next setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.btn_next setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
    self.btn_next.layer.masksToBounds = YES;
    self.btn_next.layer.cornerRadius = 3.0f;
    [self.btn_next setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
    self.btn_next.enabled = NO;
    [self.btn_next addTarget:self action:@selector(btn_nextAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btn_nextAction{
    if (self.tf_newCode.text != self.tf_sureCode.text) {
        [MBProgressHUD showInfoMessage:@"请输入相同密码"];
        return;
    }
//    NSString *strUrl = @"http://47.97.174.40:9000/login/updateOper";
    NSString *strUrl = [NSString stringWithFormat:@"%@/login/updateOper",API_Login];
    NSDictionary *dic = @{@"account":[LoginStorage GetUserName],@"password":self.tf_sureCode.text};
    //    NSDictionary *dic = @{@"account":@"oper001",@"password":@"123456"};
    RTHttpClient *asas = [[RTHttpClient alloc]init];
    [asas requestWithPath:strUrl method:RTHttpRequestPost parameters:dic prepare:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
            NSArray *arr_vc = self.navigationController.viewControllers;
            for (NSUInteger index = arr_vc.count - 1; arr_vc >= 0; index--) {
                UIViewController *vc = [arr_vc objectAtIndex:index];
                if (![vc isKindOfClass:[SetPassWordViewController class]] && ![vc isKindOfClass:[FindPwWithCodeViewController class]] && ![vc isKindOfClass:[FindPwWithUserNameViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error == %@",error);
        
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tf_newCode) {
        
        NSMutableString * changedString=[[NSMutableString alloc]initWithString:textField.text];
        [changedString replaceCharactersInRange:range withString:string];
        
        if (changedString.length!=0) {
            //        NSLog(@"用户名有内容");
            self.int_userName = 1;
            
        }else{
            
            //        NSLog(@"用户名没内容");
            self.int_userName = 0;
        }
    }if (textField == self.tf_sureCode) {
        NSMutableString * changedString=[[NSMutableString alloc]initWithString:textField.text];
        [changedString replaceCharactersInRange:range withString:string];
        
        if (changedString.length!=0) {
            //            NSLog(@"密码有内容");
            self.int_passWord = 1;
        }else{
            //            NSLog(@"密码没内容");
            self.int_passWord = 0;
        }
    }
    if (self.int_userName == 1 && self.int_passWord == 1) {
        [self.btn_next setBackgroundColor:[UIColor colorWithRed:65/255.0 green:103/255.0 blue:178/255.0 alpha:1]];
        [self.btn_next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_next.enabled = YES;
    }else{
        [self.btn_next setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
        [self.btn_next setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
        self.btn_next.enabled = NO;
    }
    
    return YES;
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
