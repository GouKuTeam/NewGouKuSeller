//
//  SupplierSettingViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierSettingViewController.h"
#import "ChangePassWordViewController.h"
#import "RTHttpClient.h"
#import "LoginViewController.h"

@interface SupplierSettingViewController ()

@end

@implementation SupplierSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号设置";
}

- (void)onCreate{
    UIView *v_back1 = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 44)];
    [self.view addSubview:v_back1];
    [v_back1 setBackgroundColor:[UIColor whiteColor]];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 90, 44)];
    [v_back1 addSubview:lab1];
    [lab1 setText:@"账号"];
    [lab1 setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab1 setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(200, 0, SCREEN_WIDTH - 215, 44)];
    [v_back1 addSubview:lab2];
    [lab2 setText:[LoginStorage GetUserName]];
    [lab2 setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab2 setFont:[UIFont systemFontOfSize:16]];
    [lab2 setTextAlignment:NSTextAlignmentRight];
    
    UIView *v_back2 = [[UIView alloc]initWithFrame:CGRectMake(0, v_back1.bottom + 10, SCREEN_WIDTH, 44)];
    [self.view addSubview:v_back2];
    [v_back2 setBackgroundColor:[UIColor whiteColor]];
    
    UITapGestureRecognizer *tgp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePassWordAction)];
    [v_back2 addGestureRecognizer:tgp];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 90, 44)];
    [v_back2 addSubview:lab3];
    [lab3 setText:@"修改密码"];
    [lab3 setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab3 setFont:[UIFont systemFontOfSize:16]];
    
    UIImageView *imgjiantou = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 27, 16, 12, 13)];
    [v_back2 addSubview:imgjiantou];
    [imgjiantou setImage:[UIImage imageNamed:@"triangle_right"]];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15,SafeAreaTopHeight + 140, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:btn];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
    btn.layer.cornerRadius = 3.0f;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(tuichuAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)changePassWordAction{
    ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tuichuAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        NSString *strUrl = @"http://47.97.174.40:9000/login/out";
        NSString *strUrl = [NSString stringWithFormat:@"%@/login/out",API_Login];
        RTHttpClient *asas = [[RTHttpClient alloc]init];
        [asas requestWithPath:strUrl method:RTHttpRequestGet parameters:nil prepare:^{
            
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
    }];
    [alert addAction:forgetPassword];
    [alert addAction:again];
    [self presentViewController:alert animated:YES completion:nil];
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
