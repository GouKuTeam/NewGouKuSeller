//
//  ActiveTimeTabHeader.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/27.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveTimeTabHeader.h"

@implementation ActiveTimeTabHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.v_back = [[UIView alloc]init];
        [self addSubview:self.v_back];
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(50);
        }];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        
        self.lab_quantian = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_quantian];
        [self.lab_quantian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(self.v_back);
        }];
        [self.lab_quantian setText:@"全天"];
        [self.lab_quantian setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_quantian setFont:[UIFont systemFontOfSize:16]];
        
        self.switch_quantian = [[UISwitch alloc]init];
        [self.v_back addSubview:self.switch_quantian];
        [self.switch_quantian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 90);
            make.top.mas_equalTo(3);
        }];
        self.switch_quantian.layer.anchorPoint = CGPointMake(0, 0.3);
//        self.switch_quantian.on = NO;
        [self.switch_quantian setOn:NO animated:true];
        
        self.lab_zidingyi = [[UILabel alloc]init];
        [self addSubview:self.lab_zidingyi];
        [self.lab_zidingyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(60);
            make.height.mas_equalTo(40);
            make.centerY.equalTo(self.lab_zidingyi);
        }];
        [self.lab_zidingyi setText:@"自定义"];
        [self.lab_zidingyi setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_zidingyi setFont:[UIFont systemFontOfSize:14]];
    }
    return self;
}

@end
