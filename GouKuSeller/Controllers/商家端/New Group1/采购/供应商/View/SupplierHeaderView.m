//
//  SupplierHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierHeaderView.h"

@implementation SupplierHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:COLOR_Main];
        
        self.iv_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 56, 56)];
        [self.iv_avatar setContentMode:UIViewContentModeScaleAspectFill];
        self.iv_avatar.clipsToBounds = YES;
        self.iv_avatar.layer.cornerRadius = 2;
        self.iv_avatar.layer.masksToBounds = YES;
        [self addSubview:self.iv_avatar];
        
        self.lb_name = [[UILabel alloc]initWithFrame:CGRectMake(self.iv_avatar.right + 10, 3, SCREEN_WIDTH - self.iv_avatar.left - 20, 28)];
        [self.lb_name setTextColor:[UIColor whiteColor]];
        [self.lb_name setFont:[UIFont systemFontOfSize:20]];
        [self addSubview:self.lb_name];
        
        self.img_jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(self.lb_name.right + 10, self.lb_name.top + 2, 24, 24)];
        [self.img_jiantou setImage:[UIImage imageNamed:@"triangle_right"]];
        [self addSubview:self.img_jiantou];
        
        self.lb_startPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.lb_name.left, self.lb_name.bottom + 1, self.lb_name.width, 20)];
        [self.lb_startPrice setTextColor:[UIColor colorWithHexString:@"#EFEFEF"]];
        [self.lb_startPrice setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        [self addSubview:self.lb_startPrice];
        
    }
    return self;
}

@end
