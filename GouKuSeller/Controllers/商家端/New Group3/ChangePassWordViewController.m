//
//  ChangePassWordViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "RTHttpClient.h"
#import "LoginViewController.h"

@interface ChangePassWordViewController ()<UITextFieldDelegate>
@property (nonatomic ,strong)UITextField     *tf_jiu;
@property (nonatomic ,strong)UITextField     *tf_xin;
@property (nonatomic ,strong)UITextField     *tf_sureXin;

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
}

- (void)onCreate{
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 132)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 70, 44)];
    [v_back addSubview:lab1];
    [lab1 setText:@"旧密码"];
    [lab1 setTextColor:[UIColor blackColor]];
    [lab1 setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, 70, 44)];
    [v_back addSubview:lab2];
    [lab2 setText:@"新密码"];
    [lab2 setTextColor:[UIColor blackColor]];
    [lab2 setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 88, 70, 44)];
    [v_back addSubview:lab3];
    [lab3 setText:@"确认密码"];
    [lab3 setTextColor:[UIColor blackColor]];
    [lab3 setFont:[UIFont systemFontOfSize:16]];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:img1];
    [img1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 88, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:img2];
    [img2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    self.tf_jiu = [[UITextField alloc]initWithFrame:CGRectMake(108, 0, SCREEN_WIDTH - 108 - 15, 44)];
    [v_back addSubview:self.tf_jiu];
    [self.tf_jiu setPlaceholder:@"请输入旧密码"];
    self.tf_jiu.font = [UIFont systemFontOfSize:16];
    self.tf_jiu.delegate = self;
    self.tf_jiu.secureTextEntry = YES;
    
    self.tf_xin = [[UITextField alloc]initWithFrame:CGRectMake(108, 44, SCREEN_WIDTH - 108 - 15, 44)];
    [v_back addSubview:self.tf_xin];
    [self.tf_xin setPlaceholder:@"请输入新密码"];
    self.tf_xin.font = [UIFont systemFontOfSize:16];
    self.tf_xin.delegate = self;
    self.tf_xin.secureTextEntry = YES;
    
    self.tf_sureXin = [[UITextField alloc]initWithFrame:CGRectMake(108, 88, SCREEN_WIDTH - 108 - 15, 44)];
    [v_back addSubview:self.tf_sureXin];
    [self.tf_sureXin setPlaceholder:@"请再次确认新密码"];
    self.tf_sureXin.font = [UIFont systemFontOfSize:16];
    self.tf_sureXin.delegate = self;
    self.tf_sureXin.secureTextEntry = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15,SafeAreaTopHeight + 175, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:btn];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
    btn.layer.cornerRadius = 3.0f;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sureAction{
    if ([self.tf_jiu.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入旧密码"];
        return;
    }
    if ([self.tf_xin.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入新密码"];
        return;
    }
    if ([self.tf_sureXin.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请再次确认新密码"];
        return;
    }
    if (self.tf_xin.text != self.tf_sureXin.text) {
        [MBProgressHUD showInfoMessage:@"请输入相同的新密码"];
        return;
    }
    NSLog(@"确定修改了");
    
//    NSString *strUrl = @"http://47.97.174.40:9000/mine/changePassword";
    NSString *strUrl = [NSString stringWithFormat:@"%@/mine/changePassword",API_Login];
    NSDictionary *dic = @{@"username":[LoginStorage GetUserName],@"oldPassword":self.tf_jiu.text,@"newPassword":self.tf_xin.text};
    RTHttpClient *asas = [[RTHttpClient alloc]init];
    [asas requestWithPath:strUrl method:RTHttpRequestPost parameters:dic prepare:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
            [LoginStorage saveIsLogin:NO];
            LoginViewController *vc = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error == %@",error);
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
