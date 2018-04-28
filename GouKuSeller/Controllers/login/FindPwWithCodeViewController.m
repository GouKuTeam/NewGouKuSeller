//
//  FindPwWithCodeViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "FindPwWithCodeViewController.h"
#import "RTHttpClient.h"
#import "SetPassWordViewController.h"

#define MAX_TIMEREMAINING 60

@interface FindPwWithCodeViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UIButton          *btn_code;
@property (nonatomic, strong)UITextField        *tf_code;
@property (nonatomic ,strong)UIButton               *btn_next;
@property (nonatomic ,assign)int          int_userName;     // =1 有内容   =0没内容
@property (nonatomic        )int          timeRemaining;//剩余时间

@end

@implementation FindPwWithCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
}

- (void)onCreate{
    
    UILabel *lab_phone = [[UILabel alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 33, 70, 22 )];
    [self.view addSubview:lab_phone];
    [lab_phone setText:@"绑定手机"];
    [lab_phone setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab_phone setFont:[UIFont systemFontOfSize:16]];
    
    
    UILabel *lab_phoneDetail = [[UILabel alloc]initWithFrame:CGRectMake(99, SafeAreaTopHeight + 33 , 130, 22 )];
    [self.view addSubview:lab_phoneDetail];
    [lab_phoneDetail setText:self.phoneNum];
    [lab_phoneDetail setTextColor:[UIColor colorWithHexString:@"#616161"]];
    [lab_phoneDetail setFont:[UIFont systemFontOfSize:16]];
    
    self.btn_code = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 99, SafeAreaTopHeight + 30, 84, 28)];
    [self.view addSubview:self.btn_code];
    [self.btn_code setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btn_code setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    self.btn_code.titleLabel.font = [UIFont systemFontOfSize:14];
    self.btn_code.layer.borderWidth = 0.5f;
    self.btn_code.layer.cornerRadius = 3.0f;
    self.btn_code.layer.borderColor = [[UIColor colorWithHexString:@"#979797"] CGColor];
    self.btn_code.layer.masksToBounds = YES;
    [self.btn_code addTarget:self action:@selector(btn_codeAction:) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *img_line1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 68, SCREEN_WIDTH - 15, 0.5)];
    [self.view addSubview:img_line1];
    [img_line1 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
    
    UILabel *lab_code = [[UILabel alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 81, 64, 22 )];
    [self.view addSubview:lab_code];
    [lab_code setText:@"验证码"];
    [lab_code setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [lab_code setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_code = [[UITextField alloc]initWithFrame:CGRectMake(99, SafeAreaTopHeight + 81, SCREEN_WIDTH - 119, 22)];
    [self.view addSubview:self.tf_code];
    [self.tf_code setPlaceholder:@"请输入短信验证码"];
    [self.tf_code setTextColor:[UIColor colorWithHexString:@"#000000"]];
    [self.tf_code setFont:[UIFont systemFontOfSize:14]];
    self.tf_code.delegate = self;
    self.tf_code.keyboardType = UIKeyboardTypeNumberPad;
    self.btn_next = [[UIButton alloc]init];
    [self.btn_next setFrame:CGRectMake(15, 153 + SafeAreaTopHeight, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:self.btn_next];
    [self.btn_next setTitle:@"下一步" forState:UIControlStateNormal];
    
    [self.btn_next setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
    self.btn_next.layer.masksToBounds = YES;
    self.btn_next.layer.cornerRadius = 3.0f;
    [self.btn_next setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
    self.btn_next.enabled = NO;
    [self.btn_next addTarget:self action:@selector(btn_nextAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *img_line2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight + 118, SCREEN_WIDTH - 15, 0.5)];
    [self.view addSubview:img_line2];
    [img_line2 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
}

- (void)btn_codeAction:(UIButton *)sender{
    
//    NSString *strUrl = @"http://47.97.174.40:9000/login/getCode";
    NSString *strUrl = [NSString stringWithFormat:@"%@/login/getCode",API_Login];
    NSDictionary *dic = @{@"phone":self.phoneNum,@"account":[LoginStorage GetUserName]};
    RTHttpClient *asas = [[RTHttpClient alloc]init];
    [asas requestWithPath:strUrl method:RTHttpRequestPost parameters:dic prepare:^{

    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
            
            UIButton *button = (UIButton *)sender;button.enabled = NO;
            self.timeRemaining = MAX_TIMEREMAINING;
            [button setTitle:[NSString stringWithFormat:@"%dS",MAX_TIMEREMAINING] forState:UIControlStateDisabled];
            [self startCountDownForReauth];

        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error == %@",error);

    }];
}

- (void)startCountDownForReauth
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countingDownForReauthAction:)
                                                    userInfo:nil
                                                     repeats:YES];
    
    [timer fire];
}

//定时改变按钮名称方法（注：该方法每隔间隔时间都会调用一次）
- (void)countingDownForReauthAction:(NSTimer *)timer
{
    if (self.timeRemaining > 0) {
        NSString *string = [NSString stringWithFormat:@"%dS",self.timeRemaining--];
        [self.btn_code setTitle:string forState:UIControlStateDisabled];
        [self.btn_code setBackgroundColor:[UIColor colorWithHexString:@"#efefef"]];
        [self.btn_code setTitleColor:[UIColor colorWithHexString:@"#979797"] forState:UIControlStateNormal];
        
    }else{
        [timer invalidate];
        [self performSelectorOnMainThread:@selector(updateButtonStateAction:)
                               withObject:nil
                            waitUntilDone:NO];
    }
}

//更新验证码按钮状态
-(void)updateButtonStateAction:(id)sender
{
    //先改变状态，再设置该状态下的文字显示
    self.btn_code.enabled = YES;
    [self.btn_code setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btn_code setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
    [self.btn_code setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
}

- (void)btn_nextAction{
    
//    NSString *strUrl = @"http://47.97.174.40:9000/login/checkCode";
    NSString *strUrl = [NSString stringWithFormat:@"%@/login/checkCode",API_Login];

    NSDictionary *dic = @{@"phone":self.phoneNum,@"code":self.tf_code.text};
    RTHttpClient *asas = [[RTHttpClient alloc]init];
    [asas requestWithPath:strUrl method:RTHttpRequestPost parameters:dic prepare:^{

    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
            SetPassWordViewController *vc = [[SetPassWordViewController alloc]init];
            vc.phoneNum = self.phoneNum;
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
    if (textField == self.tf_code) {
        
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
