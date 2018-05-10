//
//  HYTabbarView.h
//  标签栏视图-多视图滑动点击切换
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTopBar.h"

@interface HYTabbarView : UIView

@property (nonatomic,strong) HYTopBar *tabbar;
@property (nonatomic,strong) UICollectionView *contentView;

- (void)addSubItemWithViewController:(UIViewController *)viewController;

- (UIViewController *)didShowViewController:(UIViewController *)viewController;

- (void)loadDataWithItem:(int)item;

- (void)scrollToTopWithItem:(int)item;

@end
