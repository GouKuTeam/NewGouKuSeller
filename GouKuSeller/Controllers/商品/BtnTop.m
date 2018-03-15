//
//  BtnTop.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BtnTop.h"

@implementation BtnTop

- (void)layoutSubviews
{    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    imageRect.size = CGSizeMake(30, 30);
    imageRect.origin.x = (self.frame.size.width - 30) ;
    imageRect.origin.y = (self.frame.size.height  - 30)/2.0f;
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = (self.frame.size.width - imageRect.size.width- titleRect.size.width);
    titleRect.origin.y = (self.frame.size.height - titleRect.size.height)/2.0f;
    self.imageView.frame = imageRect;    self.titleLabel.frame = titleRect;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
