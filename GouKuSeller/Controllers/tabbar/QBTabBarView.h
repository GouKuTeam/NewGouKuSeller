//
//  QBTabBarView.h
//  QuBo
//
//  Created by 蜜友 on 15/11/4.
//  Copyright (c) 2015年 蜜友科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBTabBarItem.h"


@protocol QBTabBarViewDelegate;



@interface QBTabBarView : UIView


@property (assign, nonatomic) id<QBTabBarViewDelegate>delegate;

/**
 *  @brief 使用特定图片来创建按钮, 这样做的好处就是可扩展性. 拿到别的项目里面去也能换图片直接用
 *
 *  @param image         普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 *  @param tag           item索引值
 *  @param itemCount     item总个数
 */
-(void)addItemWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage itemTag:(NSInteger)tagIdex count:(NSInteger)itemCount;


/**
 *  @brief item点击事件
 */
- (void)itemClick:(QBTabBarItem *)item;


@end


@protocol QBTabBarViewDelegate <NSObject>

/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void)tabBarView:(QBTabBarView *)tabBarView selectedFrom:(NSInteger)from to:(NSInteger)to;

@end


