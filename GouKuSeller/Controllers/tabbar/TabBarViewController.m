//
//  TabBarViewController.m
//  Live
//
//  Created by 蜜友 on 15/8/3.
//  Copyright (c) 2015年 MiYouKeJi. All rights reserved.
//

#import "TabBarViewController.h"
#import "WorkbenchViewController.h"
#import "OrderViewController.h"
#import "MyViewController.h"


#define BASE_TAG 10000

@interface TabBarViewController ()


@end



@implementation TabBarViewController


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
   
    //工作台
    WorkbenchViewController *homePage = [[WorkbenchViewController alloc] init];
    UINavigationController *homePageNav = [self changeToNavController:homePage title:@"工作台" index:1];
    
    //订单
    OrderViewController *search = [[OrderViewController alloc] init];
    UINavigationController *searchNav = [self changeToNavController:search title:@"订单" index:2];
    
    //我的
    MyViewController *message = [[MyViewController alloc] init];
    UINavigationController *messageNav = [self changeToNavController:message title:@"我的" index:3];
    
    self.viewControllers = [NSArray arrayWithObjects:homePageNav, searchNav, messageNav, nil];
    NSArray *titles = @[@"工作台",@"订单",@"我的"];
    NSArray *images = @[@"Tab_Normal_1",@"Tab_Normal_2",@"Tab_Normal_3"];
    NSArray *selectImages = @[@"Tab_Selected_1",@"Tab_Selected_2",@"Tab_Selected_3"];
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
