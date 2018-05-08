//
//  PayWaitView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PayWaitView.h"

@implementation PayWaitView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.5]];
        
        self.v_back = [[UIView alloc]init];
        [self addSubview:self.v_back];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREEN_WIDTH - 270) / 2);
            make.top.mas_equalTo((SCREEN_HEIGHT - 270 - 81) / 2);
            make.width.mas_equalTo(270);
            make.height.mas_equalTo(270);
        }];
        self.v_back.layer.cornerRadius = 12;
        self.v_back.layer.masksToBounds = YES;

        
        self.img = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img];
        [self.img setImage:[UIImage imageNamed:@"wait"]];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(88);
            make.top.mas_equalTo(70);
            make.width.mas_equalTo(92);
            make.height.mas_equalTo(86);
        }];
        
        self.lab = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab];
        [self.lab setText:@"扫描成功，等待支付"];
        [self.lab setTextAlignment:NSTextAlignmentCenter];
        self.lab.font = [UIFont systemFontOfSize:18];
        self.lab.textColor = [UIColor blackColor];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.img.mas_bottom).offset(44);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(270);
            make.height.mas_equalTo(25);
        }];
        
        self.btn_back = [[UIButton alloc]init];
        [self addSubview:self.btn_back];
        [self.btn_back setTitle:@"返回" forState:UIControlStateNormal];
        [self.btn_back setTitleColor:[UIColor colorWithHexString:@"#4167B2"] forState:UIControlStateNormal];
        [self.btn_back setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        self.btn_back.titleLabel.font = [UIFont systemFontOfSize:18];
        self.btn_back.layer.cornerRadius = 3.0f;
        self.btn_back.layer.masksToBounds = YES;
        [self.btn_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.v_back);
            make.top.equalTo(self.v_back.mas_bottom).offset(31);
            make.width.mas_equalTo(270);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}

@end
