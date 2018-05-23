//
//  SupplierTabbarViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierTabbarViewController : UITabBarController

- (void)showBadgeOnItemIndex:(int)index withCount:(int)count;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@property (nonatomic,assign)int    unViewedCount;

@end
