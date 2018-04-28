//
//  FindPwWithUserNameViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "FindPwWithUserNameViewController.h"
#import "RTHttpClient.h"
#import "FindPwWithCodeViewController.h"

@interface FindPwWithUserNameViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UITextField            *tf_userName;
@property (nonatomic ,strong)UIButton               *btn_next;
@property (nonatomic ,assign)int          int_userName;     // =1 有内容   =0没内容

@end

@implementation FindPwWithUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
}

- (void)onCreate{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 32, 40, 22)];
    [self.view addSubview:lab];
    [lab setText:@"账号"];
    [lab setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_userName = [[UITextField alloc]initWithFrame:CGRectMake(67, SafeAreaTopHeight + 32, SCREEN_WIDTH - SafeAreaTopHeight - 32 - 20, 22)];
    [self.view addSubview:self.tf_userName];
    [self.tf_userName setPlaceholder:@"请输入要找回密码的账号"];
    [self.tf_userName setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.tf_userName setFont:[UIFont systemFontOfSize:16]];
    self.tf_userName.delegate = self;
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 69, SCREEN_WIDTH - 15, 0.5)];
    [self.view addSubview:line];
    [line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    
    self.btn_next = [[UIButton alloc]init];
    [self.btn_next setFrame:CGRectMake(15, 104 + SafeAreaTopHeight, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:self.btn_next];
    [self.btn_next setTitle:@"下一步" forState:UIControlStateNormal];
    
    [self.btn_next setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn_next setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
    self.btn_next.layer.masksToBounds = YES;
    self.btn_next.layer.cornerRadius = 3.0f;
    self.btn_next.enabled = NO;
    [self.btn_next addTarget:self action:@selector(btn_nextAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btn_nextAction{
//    NSString *strUrl = @"http://47.97.174.40:9000/login/checkAccount";
    NSString *strUrl = [NSString stringWithFormat:@"%@/login/checkAccount",API_Login];
    
    NSDictionary *dic = @{@"account":self.tf_userName.text};
    //    NSDictionary *dic = @{@"account":@"oper001",@"password":@"123456"};
    RTHttpClient *asas = [[RTHttpClient alloc]init];
    [asas requestWithPath:strUrl method:RTHttpRequestPost parameters:dic prepare:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
            [LoginStorage saveUserName:self.tf_userName.text];
            FindPwWithCodeViewController *vc = [[FindPwWithCodeViewController alloc]init];
            vc.phoneNum = [responseObject objectForKey:@"data"];
            [self.navigationController pushViewController:vc animated:YES];
            
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
    if (textField == self.tf_userName) {
        
        NSMutableString * changedString=[[NSMutableString alloc]initWithString:textField.text];
        [changedString replaceCharactersInRange:range withString:string];
        
        if (changedString.length!=0) {
            //        NSLog(@"用户名有内容");
            self.int_userName = 1;
            
        }else{
            
            //        NSLog(@"用户名没内容");
            self.int_userName = 0;
        }
    }
    if (self.int_userName == 1) {
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
