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
    [self initTabBarView];

}

/**
 * @brief 添加自定义的tabBarView
 */
- (void)initTabBarView{
    
    CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    self.tabBarView = [[QBTabBarView alloc] initWithFrame:rect];
    self.tabBarView.delegate = self;
    self.tabBarView.backgroundColor = [UIColor clearColor];
    self.tabBarView.userInteractionEnabled = YES;
    [self.tabBar addSubview:self.tabBarView];//添加到系统自带的tabBar上, 这样可以用自带的事件方法. 而不必自己去写
    
    //为控制器添加按钮
    for (int i = 0; i < self.viewControllers.count; i++) { //根据有多少个子视图控制器来进行添加按钮
        
        NSString *imageName = [NSString stringWithFormat:@"Tab_Normal_%d", i + 1];
        NSString *imageNameSel = [NSString stringWithFormat:@"Tab_Selected_%d", i + 1];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [self.tabBarView addItemWithNormalImage:image selectedImage:imageSel itemTag:i count:self.viewControllers.count];
    }
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


#pragma mark -
#pragma mark QBTabBarViewDelegate
- (void)tabBarView:(QBTabBarView *)tabBarView selectedFrom:(NSInteger)from to:(NSInteger)to{
    
    self.selectedIndex = to;

}


#pragma mark -
#pragma mark 刷新选中的item
- (void)updateTabBarSelectedItem{
    
    QBTabBarItem *tabBarItem = (QBTabBarItem *)[self.tabBarView viewWithTag:self.selectedIndex + BASE_TAG];
    [self.tabBarView itemClick:tabBarItem];
}


#pragma mark -
#pragma mark MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
