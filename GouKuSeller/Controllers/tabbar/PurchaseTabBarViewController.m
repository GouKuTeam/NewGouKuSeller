//
//  PurchaseTabBarViewController.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseTabBarViewController.h"
#import "PurchaseOrderViewController.h"
#import "ShoppingCartViewController.h"
#import "SupplierListViewController.h"

@interface PurchaseTabBarViewController ()

@end

@implementation PurchaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tabBar背景图片
    [self.tabBar setBackgroundImage:[[UIImage imageNamed:@"TabBar_Bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:24]];
    [self.tabBar setShadowImage:[UIImage imageNamed:@"TabBar_Shadow"]];
    
    //初始化Tab下的ViewController
    [self initTabBarViewControllers];
    
}

#pragma mark -
#pragma mark 初始化Tab下的ViewController
- (void)initTabBarViewControllers{
    
    SupplierListViewController *supplierVC = [[SupplierListViewController alloc] init];
    UINavigationController *supplierNav = [self changeToNavController:supplierVC title:@"供应商" index:3];
    ShoppingCartViewController *shopVC = [[ShoppingCartViewController alloc] init];
    UINavigationController *shopNav = [self changeToNavController:shopVC title:@"购物车" index:2];
    
    PurchaseOrderViewController *orderVC = [[PurchaseOrderViewController alloc] init];
    UINavigationController *orderNav = [self changeToNavController:orderVC title:@"采购订单" index:1];
    
    self.viewControllers = [NSArray arrayWithObjects:supplierNav,shopNav,orderNav, nil];
    NSArray *titles = @[@"供应商",@"购物车",@"采购订单"];
    NSArray *images = @[@"PurchaseTab_Normal_1",@"PurchaseTab_Normal_2",@"PurchaseTab_Normal_3"];
    NSArray *selectImages = @[@"PurchaseTab_Selected_1",@"PurchaseTab_Selected_2",@"PurchaseTab_Selected_3"];
    for (int i=0; i<3; i++) {
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        item.tag = i;
        item.title = [titles objectAtIndex:i];
        item.image = [[UIImage imageNamed:[images objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[selectImages objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:[NSDictionary
                                      dictionaryWithObjectsAndKeys: [UIColor colorWithHexString:@"#666666"],
                                      NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary
                                      dictionaryWithObjectsAndKeys: [UIColor colorWithHexString:@"#4167b2"],
                                      NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    
}



#pragma mark -
#pragma mark 初始化导航控制器
-(UINavigationController *)changeToNavController:(UIViewController*)viewController title:(NSString *)title index:(NSInteger)index{
    
    if (nil == viewController) {
        return nil;
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    nav.navigationBar.hidden = NO;
    nav.tabBarItem.title = title;
    
    //设置tabBarItem的title字色
    UIFont *font = [UIFont systemFontOfSize:10.f];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#666666"], NSForegroundColorAttributeName, font, NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#4167b2"], NSForegroundColorAttributeName, font, NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    return nav;
}

@end
