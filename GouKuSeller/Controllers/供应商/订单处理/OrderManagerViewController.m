//
//  OrderManagerViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderManagerViewController.h"
#import "ExportOrderViewController.h"

@interface OrderManagerViewController ()
@property (nonatomic ,strong)UIButton             *btn_daochu;

@end

@implementation OrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    // Do any additional setup after loading the view.
}

- (void)onCreate{
    self.btn_daochu = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 109, 44, 44)];
    [self.view addSubview:self.btn_daochu];
    [self.view bringSubviewToFront:self.btn_daochu];
    [self.btn_daochu setBackgroundImage:[UIImage imageNamed:@"export"] forState:UIControlStateNormal];
    [self.btn_daochu addTarget:self action:@selector(btn_daochuAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_daochu setHidden:YES];
}

- (void)btn_daochuAction{
    ExportOrderViewController *vc = [[ExportOrderViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
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
