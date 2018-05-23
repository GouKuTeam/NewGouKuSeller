//
//  AppDelegate.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarViewController.h"
#import "SupplierTabbarViewController.h"


static NSString *appKey = @"a39c6215cc0d16b9dd42db44";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;  // fales 为开发环境  如果上线需改成 true

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)TabBarViewController          *tableBarController;
@property (strong, nonatomic)SupplierTabbarViewController  *supplierTabbarViewController;

@end

