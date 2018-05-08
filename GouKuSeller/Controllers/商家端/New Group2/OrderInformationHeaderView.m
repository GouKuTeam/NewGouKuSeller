//
//  OrderInformationHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderInformationHeaderView.h"

@implementation OrderInformationHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lab_payStatus = [[UILabel alloc]init];
        [self addSubview:self.lab_payStatus];
        [self.lab_payStatus setBackgroundColor:[UIColor whiteColor]];
        [self.lab_payStatus setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lab_payStatus setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_payStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(50);
        }];
        
        
        self.v_heji = [[UIView alloc]init];
        [self addSubview:self.v_heji];
        [self.v_heji setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self.v_heji mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_payStatus);
            make.top.equalTo(self.lab_payStatus.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(48);
        }];

        self.lab_heji = [[UILabel alloc]init];
        [self.v_heji addSubview:self.lab_heji];
        [self.lab_heji setText:@"合计"];
        [self.lab_heji setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_heji setFont:[UIFont systemFontOfSize:14]];
        [self.lab_heji mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
        }];

        self.v_commodityBack = [[UIView alloc]init];
        [self addSubview:self.v_commodityBack];
        [self.v_commodityBack setBackgroundColor:[UIColor whiteColor]];
        [self.v_commodityBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_heji.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(132);
        }];

        self.lab_total = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_total];
        self.lab_total.text = @"商品总额";
        self.lab_total.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        self.lab_total.textColor = [UIColor blackColor];
        [self.lab_total mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(44);
        }];

        self.lab_totalPrice = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_totalPrice];
        self.lab_totalPrice.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        self.lab_totalPrice.textColor = [UIColor blackColor];
        self.lab_totalPrice.textAlignment = NSTextAlignmentRight;
        [self.lab_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 210);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(44);
        }];

        self.lab_youhui = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_youhui];
        self.lab_youhui.text = @"优惠金额";
        self.lab_youhui.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        self.lab_youhui.textColor = [UIColor blackColor];
        [self.lab_youhui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(44);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(44);
        }];

        self.lab_youhuiPrice = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_youhuiPrice];
        self.lab_youhuiPrice.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        self.lab_youhuiPrice.textColor = [UIColor blackColor];
        self.lab_youhuiPrice.textAlignment = NSTextAlignmentRight;
        [self.lab_youhuiPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 210);
            make.top.mas_equalTo(44);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(44);
        }];
        self.lab_youhuiPrice.text = @"-¥100";

        self.lab_zhifu = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_zhifu];
        self.lab_zhifu.text = @"实付金额";
        self.lab_zhifu.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        self.lab_zhifu.textColor = [UIColor blackColor];
        [self.lab_zhifu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(88);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(44);
        }];

        self.lab_zhifuPrice = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_zhifuPrice];
        self.lab_zhifuPrice.font = [UIFont boldSystemFontOfSize:16];
        self.lab_zhifuPrice.textColor = [UIColor blackColor];
        self.lab_zhifuPrice.textAlignment = NSTextAlignmentRight;
        [self.lab_zhifuPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 210);
            make.top.mas_equalTo(88);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(44);
        }];

        self.line1 = [[UIImageView alloc]init];
        [self.v_commodityBack addSubview:self.line1];
        [self.line1 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(SCREEN_WIDTH - 10);
            make.top.mas_equalTo(44);
            make.height.mas_equalTo(0.5);
        }];

        self.line2 = [[UIImageView alloc]init];
        [self.v_commodityBack addSubview:self.line2];
        [self.line2 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(SCREEN_WIDTH - 10);
            make.top.mas_equalTo(88);
            make.height.mas_equalTo(0.5);
        }];

        self.v_payBack = [[UIView alloc]init];
        [self addSubview:self.v_payBack];
        [self.v_payBack setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self.v_payBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_commodityBack.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(47);
        }];

        self.lab_payType = [[UILabel alloc]init];
        [self.v_payBack addSubview:self.lab_payType];
        self.lab_payType.font = [UIFont systemFontOfSize:14];
        [self.lab_payType setText:@"支付方式"];
        self.lab_payType.textColor = [UIColor colorWithHexString:@"#616161"];
        [self.lab_payType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(19);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
        }];

        self.v_payBack2 = [[UIView alloc]init];
        [self addSubview:self.v_payBack2];
        [self.v_payBack2 setBackgroundColor:[UIColor whiteColor]];
        [self.v_payBack2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_payBack.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(47);
        }];

        self.lab_payTypeName = [[UILabel alloc]init];
        [self.v_payBack2 addSubview:self.lab_payTypeName];
        self.lab_payTypeName.font = [UIFont systemFontOfSize:16];
        self.lab_payTypeName.textColor = [UIColor blackColor];
        [self.lab_payTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(44);
        }];
        [self.lab_payTypeName setText:@"微信支付"];
//
        self.lab_payTypePrice = [[UILabel alloc]init];
        [self.v_payBack2 addSubview:self.lab_payTypePrice];
        self.lab_payTypePrice.font = [UIFont systemFontOfSize:16];
        self.lab_payTypePrice.textColor = [UIColor blackColor];
        [self.lab_payTypePrice setTextAlignment:NSTextAlignmentRight];
        [self.lab_payTypePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 210);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(44);
        }];

        self.v_commodityBack = [[UIView alloc]init];
        [self addSubview:self.v_commodityBack];
        [self.v_commodityBack setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self.v_commodityBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_payBack2.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(47);
        }];

        self.lab_commodity = [[UILabel alloc]init];
        [self.v_commodityBack addSubview:self.lab_commodity];
        self.lab_commodity.font = [UIFont systemFontOfSize:14];
        [self.lab_commodity setText:@"商品"];
        self.lab_commodity.textColor = [UIColor colorWithHexString:@"#616161"];
        [self.lab_commodity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(19);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

@end
