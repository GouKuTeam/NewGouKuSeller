//
//  MoreEditCommodityChildView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "MoreEditCommodityChildView.h"

@implementation MoreEditCommodityChildView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [[UIColor colorWithHexString:@"#d8d8d8"] CGColor];
        self.layer.borderWidth = 0.5;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        
        self.btn_edit = [[UIButton alloc]initWithFrame:CGRectMake(0,0,frame.size.width, 44)];
        [self addSubview:self.btn_edit];
//        [self.btn_edit setTitle:@"发布到门店" forState:UIControlStateNormal];
        self.btn_edit.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_edit setTitleColor:[UIColor colorWithHexString:@"4167b2"] forState:UIControlStateNormal];

        self.img_mid_line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.5, frame.size.width, 0.5)];
        [self addSubview:self.img_mid_line];
        [self.img_mid_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        self.btn_delege = [[UIButton alloc]initWithFrame:CGRectMake(0, 44, frame.size.width, 44)];
        [self addSubview:self.btn_delege];
        [self.btn_delege setTitle:@"删除" forState:UIControlStateNormal];
        self.btn_delege.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_delege setTitleColor:[UIColor colorWithHexString:@"4167b2"] forState:UIControlStateNormal];
    }
    return self;
}
@end
