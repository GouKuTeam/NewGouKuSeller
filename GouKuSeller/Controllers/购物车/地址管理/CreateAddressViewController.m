//
//  CreateAddressViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CreateAddressViewController.h"
#import "GCPlaceholderTextView.h"
#import "LocationAddressViewController.h"

@interface CreateAddressViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UITextField                   *tf_name;
@property (nonatomic ,strong)UITextField                   *tf_phone;
@property (nonatomic ,strong)GCPlaceholderTextView         *tf_address;
@end

@implementation CreateAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 220)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *labname = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 75, 44)];
    [v_back addSubview:labname];
    [labname setText:@"联系人"];
    [labname setTextColor:[UIColor blackColor]];
    [labname setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *labphone = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, 75, 44)];
    [v_back addSubview:labphone];
    [labphone setText:@"手机号码"];
    [labphone setTextColor:[UIColor blackColor]];
    [labphone setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *labadress = [[UILabel alloc]initWithFrame:CGRectMake(15, 88, 75, 44)];
    [v_back addSubview:labadress];
    [labadress setText:@"所在地区"];
    [labadress setTextColor:[UIColor blackColor]];
    [labadress setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *labaddressDetail = [[UILabel alloc]initWithFrame:CGRectMake(15, 132, 75, 44)];
    [v_back addSubview:labaddressDetail];
    [labaddressDetail setText:@"详细地址"];
    [labaddressDetail setTextColor:[UIColor blackColor]];
    [labaddressDetail setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_name = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 50, 44)];
    [v_back addSubview:self.tf_name];
    [self.tf_name setTextColor:[UIColor blackColor]];
    [self.tf_name setPlaceholder:@"名字"];
    self.tf_name.font = [UIFont systemFontOfSize:16];
    self.tf_name.delegate = self;
    
    self.tf_phone = [[UITextField alloc]initWithFrame:CGRectMake(100, 44, SCREEN_WIDTH - 50, 44)];
    [v_back addSubview:self.tf_phone];
    [self.tf_phone setTextColor:[UIColor blackColor]];
    [self.tf_phone setPlaceholder:@"11位手机号"];
    self.tf_phone.keyboardType = UIKeyboardTypeNumberPad;
    self.tf_phone.font = [UIFont systemFontOfSize:16];
    self.tf_phone.delegate = self;
    
    self.tf_address = [[GCPlaceholderTextView alloc]initWithFrame:CGRectMake(100, 138, SCREEN_WIDTH - 150, 75)];
    [v_back addSubview:self.tf_address];
    [self.tf_address setTextColor:[UIColor blackColor]];
    [self.tf_address setPlaceholder:@"街道门牌信息"];
    self.tf_address.font = [UIFont systemFontOfSize:16];
    [self.tf_address setEditable:NO];
    UITapGestureRecognizer *tgp_address = [[UITapGestureRecognizer alloc]init];
    [self.tf_address addGestureRecognizer:tgp_address];
    [tgp_address addTarget:self action:@selector(tgp_addressAction)];
    
    UIButton *btn_dingwei = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 31, 145, 16, 18)];
    [v_back addSubview:btn_dingwei];
    [btn_dingwei setImage:[UIImage imageNamed:@"locationgrey"] forState:UIControlStateNormal];
    
    UIImageView *imgline1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:imgline1];
    [imgline1 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
    
    UIImageView *imgline2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 88, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:imgline2];
    [imgline2 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
    
    UIImageView *imgline3 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 132, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:imgline3];
    [imgline3 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
}

- (void)tgp_addressAction{
    LocationAddressViewController *vc = [[LocationAddressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarAction{
    
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
