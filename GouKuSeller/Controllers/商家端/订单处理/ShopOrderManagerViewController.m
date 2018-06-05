//
//  ShopOrderManagerViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopOrderManagerViewController.h"
#import "ShopOrderManagerView.h"
#import "TabBarViewController.h"

@interface ShopOrderManagerViewController ()

@property (nonatomic ,strong)ShopOrderManagerView      *v_header;
@property (nonatomic ,assign)int                        selectIndex;


@end

@implementation ShopOrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)onCreate{
    self.v_header = [[ShopOrderManagerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaStatusBarHeight + 72)];
    [self.view addSubview:self.v_header];
    WS(weakSelf);
    self.v_header.selectType = ^(NSInteger index) {
        if (index == 1) {
            index = 2;
        }
        weakSelf.selectIndex = (int)index;
//        [weakSelf.tb_orderManager requestDataSource];
    };
    [self.v_header setItemWithIndex:0];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
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
