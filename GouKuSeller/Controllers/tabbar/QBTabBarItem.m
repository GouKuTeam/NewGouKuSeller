//
//  QBTabBarItem.m
//  QuBo
//
//  Created by 蜜友 on 15/11/4.
//  Copyright (c) 2015年 蜜友科技. All rights reserved.
//

#import "QBTabBarItem.h"

#define BADGE_WIDTH 9.f
#define BADGE_HEIGHT 9.f
#define BADGE_FONT 5.f

@implementation QBTabBarItem


- (id)initWithFrame:(CGRect)frame normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = NO;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:selectedImage forState:UIControlStateSelected];
        
        self.badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*3/5 - 2.f, frame.size.height/4 - 2.f, BADGE_WIDTH, BADGE_HEIGHT)];
        self.badgeLabel.textColor = [UIColor whiteColor];
        self.badgeLabel.backgroundColor = [UIColor redColor];
        self.badgeLabel.layer.cornerRadius = BADGE_HEIGHT/2;
        self.badgeLabel.layer.masksToBounds = YES;
        self.badgeLabel.font = [UIFont systemFontOfSize:BADGE_FONT];
        self.badgeLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeLabel.hidden = YES;
        [self addSubview:self.badgeLabel];
    }
    
    return self;
}






@end
