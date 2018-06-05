//
//  TabBarViewController.h
//  Live
//
//  Created by 蜜友 on 15/8/3.
//  Copyright (c) 2015年 MiYouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UITabBarController

- (void)showBadgeOnItemIndex:(int)index withCount:(int)count;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@property (nonatomic,assign)int    unViewedCount;

@end
