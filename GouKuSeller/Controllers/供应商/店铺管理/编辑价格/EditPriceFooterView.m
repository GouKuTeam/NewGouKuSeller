//
//  EditPriceFooterView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditPriceFooterView.h"

@implementation EditPriceFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *v_line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [v_line1 setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self addSubview:v_line1];
        
        self.btn_add = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
        [self addSubview:self.btn_add];
        [self.btn_add setBackgroundColor:[UIColor whiteColor]];
        [self.btn_add setTitle:@"添加出售单位" forState:UIControlStateNormal];
        [self.btn_add setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        [self.btn_add setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self.btn_add setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
        self.btn_add.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        
    }
    return self;
}

@end
