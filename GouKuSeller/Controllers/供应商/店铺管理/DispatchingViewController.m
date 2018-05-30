//
//  DispatchingViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "DispatchingViewController.h"
#import "SupplierOrderHandler.h"

@interface DispatchingViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong)UITextField           *tf_minimumDeliveryAmount;   //起送价
@property (nonatomic ,strong)UITextField           *tf_freight;                 //运费
@property (nonatomic ,strong)UIButton              *btn_save;
@property (nonatomic ,strong)NSString              *minimumDeliveryAmount;
@property (nonatomic ,strong)NSString              *freight;


@end

@implementation DispatchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配送";
}

- (void)onCreate{
    UIView *v_back = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH, 88)];
    [self.view addSubview:v_back];
    [v_back setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lab_minimumDeliveryAmount = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 60, 44)];
    [v_back addSubview:lab_minimumDeliveryAmount];
    [lab_minimumDeliveryAmount setText:@"起送价"];
    [lab_minimumDeliveryAmount setTextColor:[UIColor blackColor]];
    [lab_minimumDeliveryAmount setFont:[UIFont systemFontOfSize:16]];
    
    UILabel *lab_freight = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, 60, 44)];
    [v_back addSubview:lab_freight];
    [lab_freight setText:@"运费"];
    [lab_freight setTextColor:[UIColor blackColor]];
    [lab_freight setFont:[UIFont systemFontOfSize:16]];
    
    self.tf_minimumDeliveryAmount = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, SCREEN_WIDTH - 105, 44)];
    [v_back addSubview:self.tf_minimumDeliveryAmount];
    [self.tf_minimumDeliveryAmount setPlaceholder:@"请输入起送价"];
    [self.tf_minimumDeliveryAmount setTextColor:[UIColor blackColor]];
    [self.tf_minimumDeliveryAmount setFont:[UIFont systemFontOfSize:16]];
    self.tf_minimumDeliveryAmount.delegate = self;
    [self.tf_minimumDeliveryAmount setTextAlignment:NSTextAlignmentRight];
    
    self.tf_freight = [[UITextField alloc]initWithFrame:CGRectMake(90, 44, SCREEN_WIDTH - 105, 44)];
    [v_back addSubview:self.tf_freight];
    [self.tf_freight setPlaceholder:@"请输入运费"];
    [self.tf_freight setTextColor:[UIColor blackColor]];
    [self.tf_freight setFont:[UIFont systemFontOfSize:16]];
    self.tf_freight.delegate = self;
    [self.tf_freight setTextAlignment:NSTextAlignmentRight];
    
    UIImageView *img_line = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, 0.5)];
    [v_back addSubview:img_line];
    [img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    
    self.btn_save = [[UIButton alloc]initWithFrame:CGRectMake(15, v_back.bottom + 21, SCREEN_WIDTH - 30, 46)];
    [self.view addSubview:self.btn_save];
    [self.btn_save setTitle:@"保存" forState:UIControlStateNormal];
    [self.btn_save setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.btn_save.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.btn_save setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
    [self.btn_save addTarget:self action:@selector(btn_saveAction) forControlEvents:UIControlEventTouchUpInside];
    [self loadData];
    
}

- (void)loadData{
    [SupplierOrderHandler getSupplierPriceWithDispatchingPrice:nil takeOffPrice:nil prepare:^{
        
    } success:^(id obj) {
        if ([[obj objectForKey:@"dispatchingPrice"] doubleValue] > 0) {
            self.tf_freight.text = [NSString stringWithFormat:@"¥%.2f",[[obj objectForKey:@"dispatchingPrice"] doubleValue]];
        }
        if ([[obj objectForKey:@"takeOffPrice"] doubleValue] > 0) {
            self.tf_minimumDeliveryAmount.text = [NSString stringWithFormat:@"¥%.2f",[[obj objectForKey:@"takeOffPrice"] doubleValue]];
        }
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)btn_saveAction{
    [self.tf_freight resignFirstResponder];
    [self.tf_minimumDeliveryAmount resignFirstResponder];
    if ([self.tf_minimumDeliveryAmount.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入起送价"];
        return;
    }
    if ([self.tf_freight.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请输入运费"];
        return;
    }
    self.minimumDeliveryAmount = [self.tf_minimumDeliveryAmount.text substringFromIndex:1];
    self.freight = [self.tf_freight.text substringFromIndex:1];
    [SupplierOrderHandler setSupplierPriceWithDispatchingPrice:self.freight takeOffPrice:self.minimumDeliveryAmount prepare:^{
        
    } success:^(id obj) {
        [MBProgressHUD showSuccessMessage:@"设置成功成功"];
        [self performSelector:@selector(setCompleteAction) withObject:nil afterDelay:1];
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"%ld:%@",statusCode,json]];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.tf_minimumDeliveryAmount) {
       [self.tf_minimumDeliveryAmount setText:[NSString stringWithFormat:@"¥%.2f",[textField.text doubleValue]]];
        
    }
    if (textField == self.tf_freight) {
        [self.tf_freight setText:[NSString stringWithFormat:@"¥%.2f",[textField.text doubleValue]]];
        
    }
    
}

- (void)setCompleteAction{
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
