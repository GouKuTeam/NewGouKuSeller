//
//  SettlementView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/28.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SettlementView.h"

@implementation SettlementView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.v_header = [[UIView alloc]init];
        [self addSubview:self.v_header];
        [self.v_header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(200);
        }];
        [self.v_header setBackgroundColor:[UIColor colorWithHexString:COLOR_Main]];
        
        self.lab_price_balance = [[UILabel alloc]init];
        [self.v_header addSubview:self.lab_price_balance];
        [self.lab_price_balance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(39);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        [self.lab_price_balance setTextColor:[UIColor whiteColor]];
        [self.lab_price_balance setFont:[UIFont systemFontOfSize:32]];
//        [self.lab_price_balance setText:@"¥200.00"];
        [self.lab_price_balance setTextAlignment:NSTextAlignmentCenter];
        

        self.lab_price_balanceT = [[UILabel alloc]init];
        [self.v_header addSubview:self.lab_price_balanceT];
        [self.lab_price_balanceT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_price_balance.mas_bottom).offset(7);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        [self.lab_price_balanceT setTextColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        [self.lab_price_balanceT setFont:[UIFont systemFontOfSize:15]];
        [self.lab_price_balanceT setText:@"可提现余额"];
        [self.lab_price_balanceT setTextAlignment:NSTextAlignmentCenter];
        
        self.btn_mingxi = [[UIButton alloc]init];
        [self.v_header addSubview:self.btn_mingxi];
        [self.btn_mingxi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREEN_WIDTH - 110) / 2);
            make.top.equalTo(self.lab_price_balanceT.mas_bottom).offset(24);
            make.width.mas_equalTo(110);
        }];
        [self.btn_mingxi setTitle:@"余额明细" forState: UIControlStateNormal];
        [self.btn_mingxi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_mingxi.layer.borderWidth = 1.0f;
        self.btn_mingxi.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.btn_mingxi.layer.cornerRadius = 3.0f;
        self.btn_mingxi.layer.masksToBounds = YES;
        
        self.v_backTiXian = [[UIView alloc]init];
        [self addSubview:self.v_backTiXian];
        [self.v_backTiXian setBackgroundColor:[UIColor whiteColor]];
        
        self.btn_tixian = [[UIButton alloc]init];
        [self.v_backTiXian addSubview:self.btn_tixian];
        [self.btn_tixian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(26);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.height.mas_equalTo(46);
        }];
        [self.btn_tixian setTitle:@"提现" forState:UIControlStateNormal];
        [self.btn_tixian setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [self.btn_tixian setBackgroundColor:[UIColor colorWithHexString:@"#4167b2"]];
        self.btn_tixian.titleLabel.font = [UIFont systemFontOfSize:18];
        self.btn_tixian.layer.cornerRadius = 3.0f;
        self.btn_tixian.layer.masksToBounds = YES;
        
        
        self.btn_chongzhi = [[UIButton alloc]init];
        [self.v_backTiXian addSubview:self.btn_chongzhi];
        [self.btn_chongzhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.btn_tixian.mas_bottom).offset(20);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.height.mas_equalTo(46);
        }];
        [self.btn_chongzhi setTitle:@"充值" forState:UIControlStateNormal];
        [self.btn_chongzhi setTitleColor:[UIColor colorWithHexString:@"#4167B2"] forState:UIControlStateNormal];
        [self.btn_chongzhi setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        self.btn_chongzhi.titleLabel.font = [UIFont systemFontOfSize:18];
        self.btn_chongzhi.layer.cornerRadius = 3.0f;
        self.btn_chongzhi.layer.masksToBounds = YES;
        self.btn_chongzhi.layer.borderWidth = 1.0f;
        self.btn_chongzhi.layer.borderColor = [[UIColor colorWithHexString:@"#4167B2"] CGColor];
        [self.btn_chongzhi setHidden:YES];
        
        if ([[LoginStorage GetTypeStr] isEqualToString:@"3"]) {
            //供应商
            [self.v_backTiXian mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.equalTo(self.v_header.mas_bottom);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(163);
            }];
            [self.btn_chongzhi setHidden:NO];
        }else{
            [self.v_backTiXian mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.equalTo(self.v_header.mas_bottom);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(100);
                [self.btn_chongzhi setHidden:YES];
            }];
        }
        
        self.v_backJieSuan = [[UIView alloc]init];
        [self addSubview:self.v_backJieSuan];
        [self.v_backJieSuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_backTiXian.mas_bottom).offset(14);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(97);
        }];
        [self.v_backJieSuan setBackgroundColor:[UIColor whiteColor]];
        
        self.lab_jiesuanT = [[UILabel alloc]init];
        [self.v_backJieSuan addSubview:self.lab_jiesuanT];
        [self.lab_jiesuanT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(24);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        [self.lab_jiesuanT setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_jiesuanT setText:@"待结算金额"];
        [self.lab_jiesuanT setFont:[UIFont systemFontOfSize:16]];
        [self.lab_jiesuanT setTextAlignment:NSTextAlignmentCenter];
        
        self.lab_jiesuanPrice = [[UILabel alloc]init];
        [self.v_backJieSuan addSubview:self.lab_jiesuanPrice];
        [self.lab_jiesuanPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_jiesuanT.mas_bottom).offset(8);
            make.left.width.equalTo(self.lab_jiesuanT);
        }];
//        [self.lab_jiesuanPrice setText:@"¥150.00"];
        [self.lab_jiesuanPrice setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_jiesuanPrice setFont:[UIFont systemFontOfSize:20]];
        [self.lab_jiesuanPrice setTextAlignment:NSTextAlignmentCenter];
        
        self.lab_miaoshu = [[UILabel alloc]init];
        [self addSubview:self.lab_miaoshu];
        [self.lab_miaoshu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.v_backJieSuan.mas_bottom).offset(14);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        self.lab_miaoshu.numberOfLines = 0;
        [self.lab_miaoshu setText:@"由于订单异常的原因，待结算金额可能与实际结算金额不同。"];
        [self.lab_miaoshu setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_miaoshu setFont:[UIFont systemFontOfSize:13]];
        [self.lab_miaoshu setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}

@end
