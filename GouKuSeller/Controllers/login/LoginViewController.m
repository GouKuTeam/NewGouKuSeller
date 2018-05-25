//
//  LoginViewController.m
//  GouKuBD
//
//  Created by 窦建斌 on 2018/3/5.
//  Copyright © 2018年 lixiao. All rights reserved.
//

#import "LoginViewController.h"
#import "RTHttpClient.h"
#import "SelectShopViewController.h"
#import "CommodityViewController.h"
#import "TabBarViewController.h"
#import "FindPwWithUserNameViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UITextField *tef_userName;
@property (nonatomic ,strong)UITextField *tef_passWord;
@property (nonatomic ,strong)UIButton    *btn_login;
@property (nonatomic ,assign)int          int_userName;     // =1 有内容   =0没内容
@property (nonatomic ,assign)int          int_passWord;
@property (nonatomic ,strong)UIButton    *btn_findPassWord;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.isHideLeftBtn = YES;
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"登录";
}

- (void)onCreate{
    UILabel *lab_userName = [[UILabel alloc]init];
     [lab_userName setFrame:CGRectMake(15,SafeAreaTopHeight + 27, 40, 20)];
    [self.view addSubview:lab_userName];
    [lab_userName setText:@"账号"];
    [lab_userName setTextColor:[UIColor blackColor]];
    [lab_userName setFont:[UIFont systemFontOfSize:16]];
    
    
    self.tef_userName = [[UITextField alloc]init];
    [self.tef_userName setFrame:CGRectMake(70, SafeAreaTopHeight + 27, SCREEN_WIDTH - 77, 20)];
    [self.view addSubview:self.tef_userName];
    self.tef_userName.placeholder = @"请输入账号";
    self.tef_userName.delegate = self;
    
    UIImageView * img_heng1 = [[UIImageView alloc]init];
    [img_heng1 setFrame:CGRectMake(15, 67 + SafeAreaTopHeight, SCREEN_WIDTH - 15, 1)];
    [self.view addSubview:img_heng1];
    [img_heng1 setBackgroundColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1]];
    
    UILabel *lab_passWord = [[UILabel alloc]init];
    [lab_passWord setFrame:CGRectMake(15, SafeAreaTopHeight + 86, 40, 20)];
    [self.view addSubview:lab_passWord];
    [lab_passWord setText:@"密码"];
    [lab_passWord setTextColor:[UIColor blackColor]];
    [lab_passWord setFont:[UIFont systemFontOfSize:16]];
    
    self.tef_passWord = [[UITextField alloc]init];
    [self.tef_passWord setFrame:CGRectMake(70, SafeAreaTopHeight + 86, SCREEN_WIDTH - 77, 20)];
    [self.view addSubview:self.tef_passWord];
    self.tef_passWord.placeholder = @"请输入密码";
    self.tef_passWord.delegate = self;
    
    UIImageView * img_heng2 = [[UIImageView alloc]init];
    [img_heng2 setFrame:CGRectMake(15, 127 + SafeAreaTopHeight, SCREEN_WIDTH - 15, 1)];
    [self.view addSubview:img_heng2];
    [img_heng2 setBackgroundColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1]];
    
    self.btn_login = [[UIButton alloc]init];
    [self.btn_login setFrame:CGRectMake(15, 155 + SafeAreaTopHeight, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:self.btn_login];
    [self.btn_login setTitle:@"登录" forState:UIControlStateNormal];
    
    [self.btn_login setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
    self.btn_login.layer.masksToBounds = YES;
    self.btn_login.layer.cornerRadius = 3.0f;
    [self.btn_login setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
    self.btn_login.enabled = NO;
    [self.btn_login addTarget:self action:@selector(btn_loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btn_findPassWord = [[UIButton alloc]init];
    [self.btn_findPassWord setFrame:CGRectMake(0, 224 + SafeAreaTopHeight, SCREEN_WIDTH, 20)];
    [self.view addSubview:self.btn_findPassWord];
    [self.btn_findPassWord setTitle:@"找回密码" forState:UIControlStateNormal];
    self.btn_findPassWord.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn_findPassWord setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
    [self.btn_findPassWord addTarget:self action:@selector(findPassWordAction) forControlEvents:UIControlEventTouchUpInside];
    
        
}

- (void)btn_loginAction{
//    NSString *strUrl = @"http://47.97.174.40:9000/login";
    NSString *strUrl = [NSString stringWithFormat:@"%@/login",API_Login];

    NSDictionary *dic = @{@"account":self.tef_userName.text,@"password":self.tef_passWord.text};
    RTHttpClient *asas = [[RTHttpClient alloc]init];
    [asas requestWithPath:strUrl method:RTHttpRequestPost parameters:dic prepare:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
            [LoginStorage saveHTTPHeader:[[responseObject objectForKey:@"data"] objectForKey:@"token"]];
            [LoginStorage saveUserName:self.tef_userName.text];
            SelectShopViewController *vc = [[SelectShopViewController alloc]init];
            vc.arr_shop = [[[responseObject objectForKey:@"data"] objectForKey:@"list"] objectForKey:@"data"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error == %@",error);
    }];
}
//找回密码
- (void)findPassWordAction{
    FindPwWithUserNameViewController *vc = [[FindPwWithUserNameViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tef_userName resignFirstResponder];
    [self.tef_passWord resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    NSLog(@"已经开始编辑文本框时执行的方法%@", textField.text);
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    NSLog(@"已经结束编辑时执行的方法%@", textField.text);
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tef_userName) {
        
    NSMutableString * changedString=[[NSMutableString alloc]initWithString:textField.text];
    [changedString replaceCharactersInRange:range withString:string];
    
    if (changedString.length!=0) {
//        NSLog(@"用户名有内容");
        self.int_userName = 1;
        
    }else{

//        NSLog(@"用户名没内容");
        self.int_userName = 0;
    }
    }if (textField == self.tef_passWord) {
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
       [self.btn_login setBackgroundColor:[UIColor colorWithRed:65/255.0 green:103/255.0 blue:178/255.0 alpha:1]];
        [self.btn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_login.enabled = YES;
    }else{
        [self.btn_login setTitleColor:[UIColor colorWithRed:199/255.0 green:222/255.0 blue:242/255.0 alpha:1] forState:UIControlStateNormal];
        [self.btn_login setBackgroundColor:[UIColor colorWithRed:93/255.0 green:132/255.0 blue:209/255.0 alpha:1]];
        self.btn_login.enabled = NO;
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
