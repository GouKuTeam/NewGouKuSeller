//
//  PayInCashCompleteView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PayInCashCompleteView.h"

@implementation PayInCashCompleteView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.img = [[UIImageView alloc]init];
        [self addSubview:self.img];
        [self.img setImage:[UIImage imageNamed:@"clock"]];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREEN_WIDTH - 92) / 2);
            make.top.mas_equalTo((SCREEN_HEIGHT - 92) / 2 - 100);
            make.width.height.mas_equalTo(92);
        }];
        
        self.lab_shifu = [[UILabel alloc]init];
        [self addSubview:self.lab_shifu];
        [self.lab_shifu setTextAlignment:NSTextAlignmentCenter];
        [self.lab_shifu setTextColor:[UIColor blackColor]];
        [self.lab_shifu setFont:[UIFont systemFontOfSize:20]];
        [self.lab_shifu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img.mas_bottom).offset(24);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(28);
        }];
        
        self.lab_zhaoling = [[UILabel alloc]init];
        [self addSubview:self.lab_zhaoling];
        [self.lab_zhaoling setTextAlignment:NSTextAlignmentCenter];
        [self.lab_zhaoling setTextColor:[UIColor blackColor]];
        [self.lab_zhaoling setFont:[UIFont systemFontOfSize:20]];
        [self.lab_zhaoling mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_shifu.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(28);
        }];
        
        self.btn_continueShou = [[UIButton alloc]init];
        [self addSubview:self.btn_continueShou];
        [self.btn_continueShou setTitle:@"继续收银" forState:UIControlStateNormal];
        [self.btn_continueShou setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [self.btn_continueShou setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
        self.btn_continueShou.titleLabel.font = [UIFont systemFontOfSize:18];
        self.btn_continueShou.layer.cornerRadius = 3.0f;
        self.btn_continueShou.layer.masksToBounds = YES;
        [self.btn_continueShou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(53);
            make.top.equalTo(self.lab_zhaoling.mas_bottom).offset(75);
            make.width.mas_equalTo(SCREEN_WIDTH - 106);
            make.height.mas_equalTo(50);
        }];
        
    }
    return self;
}

@end
