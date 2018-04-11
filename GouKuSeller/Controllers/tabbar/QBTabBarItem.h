//
//  QBTabBarItem.h
//  QuBo
//
//  Created by 蜜友 on 15/11/4.
//  Copyright (c) 2015年 蜜友科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBTabBarItem : UIButton

- (id)initWithFrame:(CGRect)frame normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage;


@property (strong, nonatomic) UILabel *badgeLabel;
@property (strong, nonatomic) NSString *badgeValue;


@end
