//
//  TiXianIngView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "TiXianIngView.h"

@implementation TiXianIngView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgStatus1 = [[UIImageView alloc]init];
        [self addSubview:self.imgStatus1];
        [self.imgStatus1 setImage:[UIImage imageNamed:@"blue_dot"]];
        [self.imgStatus1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(41);
            make.top.mas_equalTo(58);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
        }];
        
        self.imgStatus2 = [[UIImageView alloc]init];
        [self addSubview:self.imgStatus2];
        [self.imgStatus2 setImage:[UIImage imageNamed:@"clock"]];
        [self.imgStatus2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(29);
            make.top.mas_equalTo(128);
            make.width.mas_equalTo(38);
            make.height.mas_equalTo(38);
        }];
        
        self.imgStatus3 = [[UIImageView alloc]init];
        [self addSubview:self.imgStatus3];
        [self.imgStatus3 setImage:[UIImage imageNamed:@"grey_dot"]];
        [self.imgStatus3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(41);
            make.top.mas_equalTo(225);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
        }];
        
        self.lineshu1 = [[UIImageView alloc]init];
        [self addSubview:self.lineshu1];
        [self.lineshu1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self.lineshu1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(46.5);
            make.top.equalTo(self.imgStatus1.mas_bottom);
            make.width.mas_equalTo(2);
            make.bottom.equalTo(self.imgStatus2.mas_top);
        }];
        
        self.lineshu2 = [[UIImageView alloc]init];
        [self addSubview:self.lineshu2];
        [self.lineshu2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self.lineshu2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(46.5);
            make.top.equalTo(self.imgStatus2.mas_bottom);
            make.width.mas_equalTo(2);
            make.bottom.equalTo(self.imgStatus3.mas_top);
        }];
        
        self.lab_1 = [[UILabel alloc]init];
        [self addSubview:self.lab_1];
        [self.lab_1 setText:@"发起提现申请"];
        [self.lab_1 setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_1 setFont:[UIFont systemFontOfSize:16]];
        [self.lab_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(85);
            make.top.mas_equalTo(56);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_2 = [[UILabel alloc]init];
        [self addSubview:self.lab_2];
//        [self.lab_2 setText:@"2017-01-02 08:00:00"];
        [self.lab_2 setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_2 setFont:[UIFont systemFontOfSize:16]];
        [self.lab_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_1);
            make.top.equalTo(self.lab_1.mas_bottom).offset(3);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_3 = [[UILabel alloc]init];
        [self addSubview:self.lab_3];
        [self.lab_3 setText:@"提现处理中"];
        [self.lab_3 setTextColor:[UIColor colorWithHexString:@"#000000 "]];
        self.lab_3.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
        [self.lab_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_1);
            make.top.equalTo(self.lab_2.mas_bottom).offset(21);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(25);
        }];
        
        self.lab_4 = [[UILabel alloc]init];
        [self addSubview:self.lab_4];
//        [self.lab_4 setText:@"预计2018-01-02前打款   "];
        [self.lab_4 setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_4 setFont:[UIFont systemFontOfSize:16]];
        [self.lab_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_3);
            make.top.equalTo(self.lab_3.mas_bottom).offset(1);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_5 = [[UILabel alloc]init];
        [self addSubview:self.lab_5];
        [self.lab_5 setText:@"打款成功"];
        [self.lab_5 setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_5 setFont:[UIFont systemFontOfSize:16]];
        [self.lab_5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_3);
            make.top.equalTo(self.lab_4.mas_bottom).offset(49);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(22);
        }];
        
        UIImageView *imgheng = [[UIImageView alloc]init];
        [self addSubview:imgheng];
        [imgheng setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
        [imgheng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.equalTo(self.lab_5.mas_bottom).offset(38.3);
            make.width.mas_equalTo(SCREEN_WIDTH - 40);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *lab11 = [[UILabel alloc]init];
        [self addSubview:lab11];
        [lab11 setText:@"提现金额"];
        [lab11 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab11 setFont:[UIFont systemFontOfSize:14]];
        [lab11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(21);
            make.top.equalTo(imgheng.mas_bottom).offset(15.7);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_price = [[UILabel alloc]init];
        [self addSubview:self.lab_price];
//        [self.lab_price setText:@"¥400.00"];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_price setFont:[UIFont systemFontOfSize:14]];
        [self.lab_price setTextAlignment:NSTextAlignmentRight];
        [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 150);
            make.top.equalTo(imgheng.mas_bottom).offset(15.7);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *lab22 = [[UILabel alloc]init];
        [self addSubview:lab22];
        [lab22 setText:@"提现银行卡"];
        [lab22 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab22 setFont:[UIFont systemFontOfSize:14]];
        [lab22 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(21);
            make.top.equalTo(lab11.mas_bottom).offset(15);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_card = [[UILabel alloc]init];
        [self addSubview:self.lab_card];
//        [self.lab_card setText:@"招商银行(0980)"];
        [self.lab_card setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_card setFont:[UIFont systemFontOfSize:14]];
        [self.lab_card setTextAlignment:NSTextAlignmentRight];
        [self.lab_card mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 150);
            make.top.equalTo(lab11.mas_bottom).offset(15);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *lab33 = [[UILabel alloc]init];
        [self addSubview:lab33];
        [lab33 setText:@"订单编号"];
        [lab33 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab33 setFont:[UIFont systemFontOfSize:14]];
        [lab33 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(21);
            make.top.equalTo(lab22.mas_bottom).offset(15);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_orderId = [[UILabel alloc]init];
        [self addSubview:self.lab_orderId];
//        [self.lab_orderId setText:@"6565565665564"];
        [self.lab_orderId setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_orderId setFont:[UIFont systemFontOfSize:14]];
        [self.lab_orderId setTextAlignment:NSTextAlignmentRight];
        [self.lab_orderId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(100);
            make.top.equalTo(lab22.mas_bottom).offset(15);
            make.right.equalTo(self.mas_right).offset(-21);
            make.height.mas_equalTo(22);
        }];
    }
    return self;
}

@end
