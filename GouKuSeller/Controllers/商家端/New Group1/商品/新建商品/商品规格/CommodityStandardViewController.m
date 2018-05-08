//
//  CommodityStandardViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityStandardViewController.h"
#import "CommodityHandler.h"

@interface CommodityStandardViewController ()

@end

@implementation CommodityStandardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品规格";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btn_right;
    
    [self loadData];
    
}

- (void)loadData{
    [CommodityHandler getStandardWithCategoryId:3 prepare:nil success:^(id obj) {
        NSArray *arr_data = (NSArray *)obj;
        
    } failed:^(NSInteger statusCode, id json) {
        [MBProgressHUD showErrorMessage:(NSString *)json];
    }];
    
}

- (void)rightBarAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
