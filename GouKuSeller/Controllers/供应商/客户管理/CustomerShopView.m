//
//  CustomerShopView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CustomerShopView.h"

@implementation CustomerShopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *v_back1 = [[UIView alloc]init];
        [self addSubview:v_back1];
        [v_back1 setBackgroundColor:[UIColor whiteColor]];
        [v_back1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(136);
        }];
        
        self.img_head = [[UIImageView alloc]init];
        [v_back1 addSubview:self.img_head];
        self.img_head.layer.cornerRadius = 2.0f;
        [self.img_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.width.height.mas_equalTo(60);
        }];
        
        self.lab_shopName = [[UILabel alloc]init];
        [v_back1 addSubview:self.lab_shopName];
        [self.lab_shopName setTextColor: [UIColor colorWithHexString:@"#000000"]];
        [self.lab_shopName setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_head.mas_right).offset(10);
            make.top.mas_equalTo(18);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_shopPerson = [[UILabel alloc]init];
        [v_back1 addSubview:self.lab_shopPerson];
        [self.lab_shopPerson setTextColor: [UIColor colorWithHexString:@"#616161"]];
        [self.lab_shopPerson setFont:[UIFont systemFontOfSize:14]];
        [self.lab_shopPerson mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_shopName);
            make.top.equalTo(self.lab_shopName.mas_bottom).offset(6);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(20);
        }];
        
        UIImageView *img_heng = [[UIImageView alloc]init];
        [v_back1 addSubview:img_heng];
        [img_heng setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [img_heng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_head.mas_bottom).offset(14.3);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView *img_dingwei = [[UIImageView alloc]init];
        [v_back1 addSubview:img_dingwei];
        [img_dingwei setImage:[UIImage imageNamed:@"locationgrey"]];
        [img_dingwei mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(img_heng.mas_bottom).offset(15.7);
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(14);
        }];
        
        self.btn_address = [[UIButton alloc]init];
        [v_back1 addSubview:self.btn_address];
        self.btn_address.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_address setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
        [self.btn_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(31);
            make.top.equalTo(img_heng.mas_bottom).offset(12.7);
            make.right.equalTo(self.mas_right).offset(-59);
            make.height.mas_equalTo(20);
        }];
        
        UIImageView *img_shu = [[UIImageView alloc]init];
        [v_back1 addSubview:img_shu];
        [img_shu setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [img_shu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 49.5);
            make.top.equalTo(img_heng.mas_bottom).offset(6.7);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(31);
        }];
        
        self.btn_phone = [[UIButton alloc]init];
        [v_back1 addSubview:self.btn_phone];
        [self.btn_phone setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [self.btn_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 45);
            make.top.equalTo(img_heng.mas_bottom).offset(7.5);
            make.width.height.mas_equalTo(30);
        }];
        
        UIView *v_back2 = [[UIView alloc]init];
        [self addSubview:v_back2];
        [v_back2 setBackgroundColor:[UIColor whiteColor]];
        [v_back2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(v_back1);
            make.top.equalTo(v_back1.mas_bottom).offset(10);
            make.width.equalTo(v_back1);
            make.height.mas_equalTo(80);
        }];
        
        self.lab_price = [[UILabel alloc]init];
        [v_back2 addSubview:self.lab_price];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_price setFont:[UIFont boldSystemFontOfSize:18]];
        self.lab_price.textAlignment = NSTextAlignmentCenter;
        [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(17);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(20);
        }];
        
        self.lab_order = [[UILabel alloc]init];
        [v_back2 addSubview:self.lab_order];
        [self.lab_order setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_order setFont:[UIFont boldSystemFontOfSize:18]];
        self.lab_order.textAlignment = NSTextAlignmentCenter;
        [self.lab_order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH / 2);
            make.top.mas_equalTo(17);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *lab_price = [[UILabel alloc]init];
        [v_back2 addSubview:lab_price];
        [lab_price setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [lab_price setFont:[UIFont systemFontOfSize:14]];
        [lab_price setText:@"累计金额(元)"];
        lab_price.textAlignment = NSTextAlignmentCenter;
        [lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_price.mas_bottom).offset(7);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *lab_order = [[UILabel alloc]init];
        [v_back2 addSubview:lab_order];
        [lab_order setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [lab_order setFont:[UIFont systemFontOfSize:14]];
        [lab_order setText:@"累计订单(笔)"];
        lab_order.textAlignment = NSTextAlignmentCenter;
        [lab_order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH / 2);
            make.top.equalTo(self.lab_price.mas_bottom).offset(7);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

@end
