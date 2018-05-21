//
//  OrderSelectViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderSelectViewController.h"
#import "SupplierOrderSelectHeaderView.h"
#import "PurchaseOrderEntity.h"

@interface OrderSelectViewController ()

@property (nonatomic,assign)int               btnIndex;

@end

@implementation OrderSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"订单查询";
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_white"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)onCreate{
    self.btnIndex = 999;
    SupplierOrderSelectHeaderView *v_header = [[SupplierOrderSelectHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
    [self.view addSubview:v_header];
    v_header.selectItem = ^(int index) {
        if (index == 0) {
            self.btnIndex = 999;
        }
        if (index == 1) {
            self.btnIndex = 7;
        }
        if (index == 2) {
            self.btnIndex = 8;
        }
        if (index == 3) {
            self.btnIndex = 9;
        }
    };
}

- (void)searchAction{
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:[UIColor colorWithHexString:COLOR_Main] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self changeNavigationOriginal];
    self.navigationController.navigationBar.translucent = YES;
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
