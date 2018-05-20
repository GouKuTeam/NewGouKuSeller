//
//  BaseViewController.m
//  DocChat-C-iphone
//
//  Created by SeanLiu on 15/8/5.
//  Copyright (c) 2015年 juliye. All rights reserved.
//

#import "BaseViewController.h"
#import "UIColor+Util.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

//navgation变色
- (void)changeNavigationBarBackgroudColor:(UIColor *)backgroudColor TintColor:(UIColor *)tintColor TitleColor:(UIColor *)titleColor TitleFont:(CGFloat)titleFont {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor:backgroudColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:tintColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     titleColor, NSForegroundColorAttributeName,
                                                                     [UIFont boldSystemFontOfSize:titleFont], NSFontAttributeName, nil]];
    
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:backgroudColor size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)changeNavigationOriginal {
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor:[UIColor colorWithHexString:COLOR_Main]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont boldSystemFontOfSize:17.0], NSFontAttributeName, nil]];
    [self.navigationController.navigationBar setShadowImage:[UIColor imageWithColor:[UIColor clearColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];//[UIColor colorWithHexString:@"#f4f4f4"];
    if (!_isHideLeftBtn){
        [self initLeftBarView];
    }
    if (_isShowRightBtn) {
        [self initRightBarView];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkErrorHandler) name:@"k_NOTI_NETWORK_ERROR" object:nil];
    [self onCreate];
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self changeNavigationOriginal];
}

- (void)networkErrorHandler
{
    [MBProgressHUD showTipMessageInView:@"网络异常，请稍后再试"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}

- (void)initLeftBarView
{
    UIBarButtonItem *btn_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_white"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"#666666"];//to do
    self.navigationItem.leftBarButtonItem = btn_back;
}

- (void)initRightBarView
{
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction:)];
    [btn_right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"]} forState:UIControlStateNormal];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.rightBarButtonItem = btn_right;
}

- (void)leftBarAction:(id)sender {
    [MBProgressHUD hideHUD];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction:(id)sender{
    [MBProgressHUD hideHUD];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onCreate
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear: (BOOL)animated
{
    
    [super viewWillDisappear: animated];
    if (![[self.navigationController viewControllers] containsObject: self])
    {
        [MBProgressHUD hideHUD];
    }
}

@end
