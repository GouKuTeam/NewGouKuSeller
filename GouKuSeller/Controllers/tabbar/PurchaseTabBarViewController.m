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
#import "NSString+Size.h"

@interface PurchaseTabBarViewController ()

@end

@implementation PurchaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tabBar背景图片
    [self.tabBar setBackgroundImage:[[UIImage imageNamed:@"TabBar_Bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:24]];
    [self.tabBar setShadowImage:[UIImage imageNamed:@"TabBar_Shadow"]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gotoPurchaseOrder) name:@"GoToPurchaseOrder" object:nil];
    
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

- (void)gotoPurchaseOrder{
    self.selectedIndex = 2;
}

//----------------------红点的显示与消失--------------------------
- (void)showBadgeOnItemIndex:(int)index withCount:(int)count{
    if (count <= 0) {
        [self hideBadgeOnItemIndex:index];
        return;
    }
    CGFloat width = 0;
    NSString *str_count = @"";
    if (count < 10) {
        width = 16;
        str_count = [NSString stringWithFormat:@"%d",count];
    }else{
        if (count > 999) {
            str_count = @"...";
        }else{
            str_count = [NSString stringWithFormat:@"%d",count];
        }
        width = [str_count fittingLabelWidthWithHeight:16 andFontSize:[UIFont systemFontOfSize:FONT_SIZE_MEMO]] + 6;
    }
    self.unViewedCount = count;
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UILabel *badgeView = [[UILabel alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 8;
    badgeView.layer.masksToBounds = YES;
    badgeView.text = str_count;
    badgeView.textColor = [UIColor colorWithHexString:COLOR_BLUE_MAIN];
    badgeView.font = [UIFont systemFontOfSize:FONT_SIZE_MEMO];
    badgeView.textAlignment = NSTextAlignmentCenter;
    badgeView.backgroundColor = [UIColor whiteColor];
    badgeView.layer.borderColor = [[UIColor colorWithHexString:COLOR_BLUE_MAIN] CGColor];
    badgeView.layer.borderWidth = 0.5;
    CGRect tabFrame = self.tabBar.frame;
    
    //确定小红点的位置
    float percentX = (index + 0.60) / self.viewControllers.count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x-10, y-3, width, 16);
    [self.tabBar addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    self.unViewedCount = 0;
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.tabBar.subviews) {
        
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


@end
