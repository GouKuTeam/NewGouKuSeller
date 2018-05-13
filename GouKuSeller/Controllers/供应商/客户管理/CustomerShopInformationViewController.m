//
//  CustomerShopInformationViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CustomerShopInformationViewController.h"
#import "CustomerShopView.h"

@interface CustomerShopInformationViewController ()

@property (nonatomic ,strong)CustomerShopView    *customerShopView;

@end

@implementation CustomerShopInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店信息";
}

- (void)onCreate{
    self.customerShopView = [[CustomerShopView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.customerShopView];
    [self.customerShopView.img_head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,self.entity.logo]] placeholderImage:[UIImage imageNamed:@"headPic"]];
    [self.customerShopView.lab_shopName setText:self.entity.shopName];
    [self.customerShopView.lab_shopPerson setText:[NSString stringWithFormat:@"联系人：%@",self.entity.personName]];
    [self.customerShopView.btn_address setTitle:self.entity.address forState:UIControlStateNormal];
    [self.customerShopView.lab_price setText:[NSString stringWithFormat:@"%.2f",[self.entity.moneySum doubleValue]]];
    [self.customerShopView.lab_order setText:[NSString stringWithFormat:@"%@",self.entity.orderNum]];
    [self.customerShopView.btn_phone addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)phoneAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定拨打" message:self.entity.phone preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *forgetPassword = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.entity.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
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
