//
//  OrderInformationFooterView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderInformationFooterView.h"

@implementation OrderInformationFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        
        self.v_mid = [[UIView alloc]init];
        [self addSubview:self.v_mid];
        [self.v_mid setBackgroundColor:[UIColor whiteColor]];
        [self.v_mid mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(12);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(66);
        }];
        
        self.lab_orderCode = [[UILabel alloc]init];
        [self.v_mid addSubview:self.lab_orderCode];
        [self.lab_orderCode setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_orderCode setFont:[UIFont systemFontOfSize:14]];
        [self.lab_orderCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(12);
            make.width.mas_equalTo(280);
            make.height.mas_equalTo(20);
        }];
        
        self.lab_payTime = [[UILabel alloc]init];
        [self.v_mid addSubview:self.lab_payTime];
        [self.lab_payTime setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_payTime setFont:[UIFont systemFontOfSize:14]];
        [self.lab_payTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(34);
            make.width.mas_equalTo(SCREEN_WIDTH - 20);
            make.height.mas_equalTo(20);
        }];
        
        self.btn_copy = [[UIButton alloc]init];
        [self.v_mid addSubview:self.btn_copy];
        [self.btn_copy setTitle:@"复制" forState:UIControlStateNormal];
        [self.btn_copy setTitleColor:[UIColor colorWithHexString:@"#4167B2"] forState:UIControlStateNormal];
        self.btn_copy.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_copy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 42);
            make.top.mas_equalTo(12);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(20);
        }];
        
        
    }
    return self;
}

@end
