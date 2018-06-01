//
//  TiXianView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/29.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "TiXianView.h"

@implementation TiXianView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        self.v_bank = [[UIView alloc]init];
        [self addSubview:self.v_bank];
        [self.v_bank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(60);
        }];
        [self.v_bank setBackgroundColor:[UIColor colorWithHexString:@"#FAFAFA"]];
        
        self.lab_bankT = [[UILabel alloc]init];
        [self.v_bank addSubview:self.lab_bankT];
        [self.lab_bankT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.height.equalTo(self.v_bank);
            make.centerY.equalTo(self.v_bank);
        }];
        [self.lab_bankT setText:@"到账银行卡"];
        [self.lab_bankT setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_bankT setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_bankNum = [[UILabel alloc]init];
        [self.v_bank addSubview:self.lab_bankNum];
        [self.lab_bankNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_bankT.mas_right).offset(20);
            make.right.equalTo(self.mas_right).offset(-17);
            make.height.equalTo(self.v_bank);
            make.centerY.equalTo(self.v_bank);
        }];
        [self.lab_bankNum setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_bankNum setFont:[UIFont systemFontOfSize:16]];
        [self.lab_bankNum setTextAlignment:NSTextAlignmentRight];
        
        self.lab_jineT = [[UILabel alloc]init];
        [self addSubview:self.lab_jineT];
        [self.lab_jineT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.v_bank.mas_bottom).offset(24);
            make.height.mas_equalTo(22);
        }];
        [self.lab_jineT setText:@"提现金额"];
        [self.lab_jineT setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_jineT setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_qian = [[UILabel alloc]init];
        [self addSubview:self.lab_qian];
        [self.lab_qian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_jineT);
            make.top.equalTo(self.lab_jineT.mas_bottom).offset(26);
            make.height.mas_equalTo(67);
        }];
        [self.lab_qian setText:@"¥"];
        [self.lab_qian setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_qian setFont:[UIFont systemFontOfSize:48]];
        
        self.tf_price = [[UITextField alloc]init];
        [self addSubview:self.tf_price];
        [self.tf_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_qian.mas_right).offset(10);
            make.top.equalTo(self.lab_qian);
            make.height.mas_equalTo(67);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        [self.tf_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.tf_price setFont:[UIFont systemFontOfSize:48]];
        self.tf_price.keyboardType = UIKeyboardTypeDecimalPad;
        
        self.img_heng = [[UIImageView alloc]init];
        [self addSubview:self.img_heng];
        [self.img_heng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.tf_price.mas_bottom).offset(12);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_heng setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        
        self.lab_ketixian = [[UILabel alloc]init];
        [self addSubview:self.lab_ketixian];
        [self.lab_ketixian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_jineT);
            make.top.equalTo(self.img_heng.mas_bottom).offset(17);
            make.height.mas_equalTo(15);
        }];
        [self.lab_ketixian setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_ketixian setFont:[UIFont systemFontOfSize:14]];
        
        self.btn_tianxianAll = [[UIButton alloc]init];
        [self addSubview:self.btn_tianxianAll];
        [self.btn_tianxianAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_ketixian.mas_right).offset(5);
            make.top.equalTo(self.lab_ketixian);
            make.height.mas_equalTo(15);
        }];
        [self.btn_tianxianAll setTitle:@"全部提现" forState:UIControlStateNormal];
        [self.btn_tianxianAll setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_tianxianAll.titleLabel.font = [UIFont systemFontOfSize:14];
        
        self.lab_tixiancount = [[UILabel alloc]init];
        [self addSubview:self.lab_tixiancount];
        [self.lab_tixiancount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_ketixian);
            make.top.equalTo(self.lab_ketixian.mas_bottom).offset(8);
            make.height.mas_equalTo(15);
        }];
        [self.lab_tixiancount setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_tixiancount setFont:[UIFont systemFontOfSize:14]];
    }
    
    return self;
}

@end
