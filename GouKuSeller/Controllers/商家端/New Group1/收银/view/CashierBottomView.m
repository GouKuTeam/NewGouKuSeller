//
//  CashierBottomView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/29.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CashierBottomView.h"

@implementation CashierBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.v_youhuiBack = [[UIView alloc]init];
        [self addSubview:self.v_youhuiBack];
        [self.v_youhuiBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(58);
        }];
        [self.v_youhuiBack setBackgroundColor:[UIColor colorWithHexString:@"#fff2f2"]];
        
        self.lab_manjian = [[UILabel alloc]init];
        [self.v_youhuiBack addSubview:self.lab_manjian];
        [self.lab_manjian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(5);
            make.height.mas_equalTo(14);
        }];
        [self.lab_manjian setText:@"满减优惠："];
        [self.lab_manjian setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_manjian setFont:[UIFont systemFontOfSize:12]];
        
        self.lab_manjianPrice = [[UILabel alloc]init];
        [self.v_youhuiBack addSubview:self.lab_manjianPrice];
        [self.lab_manjianPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_manjian);
            make.left.equalTo(self.lab_manjian.mas_right);
            make.height.mas_equalTo(14);
        }];
        [self.lab_manjianPrice setTextColor:[UIColor colorWithHexString:@"#dc2e2e"]];
        [self.lab_manjianPrice setFont:[UIFont systemFontOfSize:12]];
        
        self.lab_zhekou = [[UILabel alloc]init];
        [self.v_youhuiBack addSubview:self.lab_zhekou];
        [self.lab_zhekou setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_zhekou setFont:[UIFont systemFontOfSize:12]];
        [self.lab_zhekou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.equalTo(self.lab_manjian.mas_bottom).offset(3);
            make.height.mas_equalTo(14);
        }];
        
        self.lab_zhekouPrice = [[UILabel alloc]init];
        [self.v_youhuiBack addSubview:self.lab_zhekouPrice];
        [self.lab_zhekouPrice setTextColor:[UIColor colorWithHexString:@"#dc2e2e"]];
        [self.lab_zhekouPrice setFont:[UIFont systemFontOfSize:12]];
        [self.lab_zhekouPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_zhekou.mas_right).offset(2);
            make.top.equalTo(self.lab_manjian.mas_bottom).offset(3);
            make.height.mas_equalTo(14);
        }];
        
        self.lab_jianjia = [[UILabel alloc]init];
        [self.v_youhuiBack addSubview:self.lab_jianjia];
        [self.lab_jianjia setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_jianjia setText:@"整单减价："];
        [self.lab_jianjia setFont:[UIFont systemFontOfSize:12]];
        [self.lab_jianjia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_zhekouPrice.mas_right).offset(28);
            make.top.equalTo(self.lab_zhekou);
            make.height.mas_equalTo(14);
        }];
        
        self.lab_jianjiaPrice = [[UILabel alloc]init];
        [self.v_youhuiBack addSubview:self.lab_jianjiaPrice];
        [self.lab_jianjiaPrice setTextColor:[UIColor colorWithHexString:@"#dc2e2e"]];
        [self.lab_jianjiaPrice setFont:[UIFont systemFontOfSize:12]];
        [self.lab_jianjiaPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_jianjia.mas_right).offset(2);
            make.top.equalTo(self.lab_zhekou);
            make.height.mas_equalTo(14);
        }];
        
        self.lab_moling = [[UILabel alloc]init];
        [self.v_youhuiBack addSubview:self.lab_moling];
        [self.lab_moling setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_moling setFont:[UIFont systemFontOfSize:12]];
        [self.lab_moling mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.equalTo(self.lab_zhekou.mas_bottom).offset(3);
            make.height.mas_equalTo(14);
        }];
        [self.lab_moling setText:@"抹零："];
        
        self.lab_molingPrice = [[UILabel alloc]init];
        [self.v_youhuiBack addSubview:self.lab_molingPrice];
        [self.lab_molingPrice setTextColor:[UIColor colorWithHexString:@"#dc2e2e"]];
        [self.lab_molingPrice setFont:[UIFont systemFontOfSize:12]];
        [self.lab_molingPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_moling.mas_right).offset(2);
            make.top.equalTo(self.lab_moling);
            make.height.mas_equalTo(14);
        }];
//        [self.lab_molingPrice setText:@"-¥0.23"];
        
        self.v_jineBack = [[UIView alloc]init];
        [self addSubview:self.v_jineBack];
        [self.v_jineBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_youhuiBack.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(46);
        }];
        [self.v_jineBack setBackgroundColor:[UIColor whiteColor]];
        
        self.lab_heji = [[UILabel alloc] init];
        [self.v_jineBack addSubview:self.lab_heji];
        [self.lab_heji mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(6);
            make.height.mas_equalTo(20);
        }];
        [self.lab_heji setText:@"合计"];
        [self.lab_heji setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_heji setFont:[UIFont systemFontOfSize:14]];
        
        self.price_zhifu = [[UILabel alloc]init];
        [self.v_jineBack addSubview:self.price_zhifu];
        [self.price_zhifu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_heji.mas_right).offset(5);
            make.top.mas_equalTo(5);
            make.height.mas_equalTo(22);
        }];
        [self.price_zhifu setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.price_zhifu setFont:[UIFont systemFontOfSize:20]];
        
        self.price_youhui = [[UILabel alloc]init];
        [self.v_jineBack addSubview:self.price_youhui];
        [self.price_youhui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.equalTo(self.price_zhifu.mas_bottom).offset(-1);
            make.height.mas_equalTo(17);
        }];
        [self.price_youhui setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.price_youhui setFont:[UIFont systemFontOfSize:12]];
        
//        self.btn_goukuPayment = [[UIButton alloc]init];
//        [self.v_jineBack addSubview:self.btn_goukuPayment];
//        [self.btn_goukuPayment mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(SCREEN_WIDTH - 110);
//            make.top.mas_equalTo(0);
//            make.width.mas_equalTo(110);
//            make.height.mas_equalTo(47);
//        }];
//        [self.btn_goukuPayment setBackgroundColor:[UIColor colorWithHexString:@"#4167b2"]];
//        [self.btn_goukuPayment setTitle:@"购酷支付" forState:UIControlStateNormal];
//        [self.btn_goukuPayment setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//        self.btn_goukuPayment.titleLabel.font = [UIFont systemFontOfSize:16];
        
        self.btn_cashPayment = [[UIButton alloc]init];
        [self.v_jineBack addSubview:self.btn_cashPayment];
        [self.btn_cashPayment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 110);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(47);
        }];
        [self.btn_cashPayment setBackgroundColor:[UIColor colorWithHexString:@"#E3EAEF"]];
        [self.btn_cashPayment setTitle:@"现金支付" forState:UIControlStateNormal];
        [self.btn_cashPayment setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_cashPayment.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

@end
