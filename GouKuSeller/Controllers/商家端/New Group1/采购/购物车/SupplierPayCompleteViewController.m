
//
//  SupplierPayCompleteViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/23.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierPayCompleteViewController.h"
#import "PayInCashCompleteView.h"
#import "PurchaseOrderViewController.h"
#import "ShoppingHandler.h"
#import "PurchaseTabBarViewController.h"

@interface SupplierPayCompleteViewController ()

@property (nonatomic ,strong)PayInCashCompleteView      *v_zhifuComplete;

@end

@implementation SupplierPayCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付结果";
    
}

- (void)onCreate{
    self.v_zhifuComplete = [[PayInCashCompleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.v_zhifuComplete.btn_continueShou setTitle:@"完成" forState:UIControlStateNormal];
    [self.v_zhifuComplete.btn_continueShou addTarget:self action:@selector(zhifucontinueAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v_zhifuComplete.lab_shifu setText:@"支付成功"];
    [self.v_zhifuComplete.lab_zhaoling setFont:[UIFont boldSystemFontOfSize:36]];
    [self.v_zhifuComplete.lab_zhaoling setText:[NSString stringWithFormat:@"¥%@",self.price]];
    [self.view addSubview:self.v_zhifuComplete];
}

- (void)zhifucontinueAction{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [ShoppingHandler getCountInShopCartprepare:^{
        
    } success:^(id obj) {
        if ([obj intValue] > 0) {
            [(PurchaseTabBarViewController *)self.tabBarController showBadgeOnItemIndex:1 withCount:[obj intValue]];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PayCompleteAndRefreshData" object:nil userInfo:nil];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.01];
}

- (void)delayMethod{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"GoToPurchaseOrder" object:nil userInfo:nil];
}

- (void)leftBarAction:(id)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PayCompleteAndRefreshData" object:nil userInfo:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
