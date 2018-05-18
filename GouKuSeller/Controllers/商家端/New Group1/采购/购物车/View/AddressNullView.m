//
//  AddressNullView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddressNullView.h"

@implementation AddressNullView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.btn_gotoAddress = [[UIButton alloc]init];
        [self.btn_gotoAddress setTitle:@"请选择地址" forState:UIControlStateNormal];
        self.btn_gotoAddress.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.btn_gotoAddress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.btn_gotoAddress];
        
        self.iv_arrow = [[UIImageView alloc]init];
        [self.iv_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
        [self addSubview:self.iv_arrow];
        
        [self.btn_gotoAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(50);
        }];
        
        [self.iv_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.left.mas_equalTo(SCREEN_WIDTH - 27);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}

@end
