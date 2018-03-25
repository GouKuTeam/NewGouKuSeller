//
//  MoreEditView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "MoreEditView.h"

@implementation MoreEditView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [[UIColor colorWithHexString:@"#d8d8d8"] CGColor];
        self.layer.borderWidth = 0.5;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.img_mid_line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, frame.size.width, 0.5)];
        [self addSubview:self.img_mid_line];
        [self.img_mid_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        self.btn_xiajia = [[UIButton alloc]initWithFrame:CGRectMake(0,0,frame.size.width, 44)];
        [self addSubview:self.btn_xiajia];
        [self.btn_xiajia setTitle:@"下架" forState:UIControlStateNormal];
        self.btn_xiajia.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"4167b2"] forState:UIControlStateNormal];
        
        self.btn_delege = [[UIButton alloc]initWithFrame:CGRectMake(0, 44, frame.size.width, 44)];
        [self addSubview:self.btn_delege];
        [self.btn_delege setTitle:@"删除" forState:UIControlStateNormal];
        self.btn_delege.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_delege setTitleColor:[UIColor colorWithHexString:@"4167b2"] forState:UIControlStateNormal];
    }
    return self;
}

@end
