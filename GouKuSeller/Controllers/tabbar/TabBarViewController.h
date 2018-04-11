//
//  TabBarViewController.h
//  Live
//
//  Created by 蜜友 on 15/8/3.
//  Copyright (c) 2015年 MiYouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBTabBarView.h"

@interface TabBarViewController : UITabBarController<QBTabBarViewDelegate>

@property (strong, nonatomic) QBTabBarView *tabBarView;


/**
 * @brief 刷新选中的item
 */
- (void)updateTabBarSelectedItem;


@end
