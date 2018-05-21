//
//  PurchaseTabBarViewController.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseTabBarViewController : UITabBarController

- (void)showBadgeOnItemIndex:(int)index withCount:(int)count;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@property (nonatomic,assign)int    unViewedCount;

@end
