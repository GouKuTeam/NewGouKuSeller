
//  SupplierViewController.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierTabbarViewController.h"
#import "OrderManagerViewController.h"
#import "OrderSelectViewController.h"
#import "CustomerManagerViewController.h"
#import "ShopManagerViewController.h"

@interface SupplierTabbarViewController ()

@end

@implementation SupplierTabbarViewController

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
    
    OrderManagerViewController *supplierVC = [[OrderManagerViewController alloc] init];
    UINavigationController *supplierNav = [self changeToNavController:supplierVC title:@"订单管理" index:4];
    OrderSelectViewController *shopVC = [[OrderSelectViewController alloc] init];
    UINavigationController *shopNav = [self changeToNavController:shopVC title:@"订单查询" index:3];
    
    CustomerManagerViewController *orderVC = [[CustomerManagerViewController alloc] init];
    UINavigationController *orderNav = [self changeToNavController:orderVC title:@"客户管理" index:2];
    ShopManagerViewController *ShopManagerVC = [[ShopManagerViewController alloc] init];
    UINavigationController *ShopManagerNav = [self changeToNavController:ShopManagerVC title:@"店铺管理" index:1];
    
    self.viewControllers = [NSArray arrayWithObjects:supplierNav,shopNav,orderNav,ShopManagerNav, nil];
    NSArray *titles = @[@"订单管理",@"订单查询",@"客户管理",@"店铺管理"];
    NSArray *images = @[@"SupplierTab_Normal_1",@"SupplierTab_Normal_2",@"SupplierTab_Normal_3",@"SupplierTab_Normal_4"];
    NSArray *selectImages = @[@"Supplier_Selected_1",@"Supplier_Selected_1_2",@"Supplier_Selected_3",@"Supplier_Selected_4"];
    for (int i=0; i<4; i++) {
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
