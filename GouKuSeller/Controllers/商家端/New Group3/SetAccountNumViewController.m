//
//  SetAccountNumViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SetAccountNumViewController.h"
#import "RTHttpClient.h"
#import "LoginViewController.h"
#import "ChangePassWordViewController.h"

@interface SetAccountNumViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic ,strong)UILabel         *labc;
@property (nonatomic ,strong)UIImageView     *img;

@end

@implementation SetAccountNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号设置";
}

- (void)onCreate{
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 44)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *laba = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 50, 44)];
    [v_back addSubview:laba];
    [laba setText:@"账号"];
    [laba setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [laba setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *labb = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 210, 0, 200, 44)];
    [v_back addSubview:labb];
    [labb setText:[LoginStorage GetUserName]];
    [labb setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [labb setFont:[UIFont systemFontOfSize:16]];
    [labb setTextAlignment:NSTextAlignmentRight];
    
    UIView *v_back2 = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 65, SCREEN_WIDTH, 44)];
    [self.view addSubview:v_back2];
    [v_back2 setBackgroundColor:[UIColor whiteColor]];
    
    
    self.labc = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
    [v_back2 addSubview:self.labc];
    [self.labc setText:@"修改密码"];
    [self.labc setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.labc setFont:[UIFont systemFontOfSize:16]];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePassWord)];
    recognizer.delegate = self;
    [v_back2 addGestureRecognizer:recognizer];
    [self.view addSubview:v_back2];
    
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 22, 14, 20, 20)];
    [v_back2 addSubview:self.img];
    [self.img setImage:[UIImage imageNamed:@"triangle_right"]];
    
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
                [LoginStorage savePrinterNum:@"1"];
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.labc] || [touch.view isDescendantOfView:self.img]) {
        return NO;
    }
    return YES;
}

- (void)changePassWord{
    ChangePassWordViewController *vc = [[ChangePassWordViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc    ];
    [self.navigationController pushViewController:vc animated:YES];
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
