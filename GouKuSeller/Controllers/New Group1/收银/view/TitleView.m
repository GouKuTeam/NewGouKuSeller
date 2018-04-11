//
//  TitleView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.5]];
        
        self.v_back = [[UIView alloc]init];
        [self addSubview:self.v_back];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(246);
        }];
        
        self.btn_addPrice = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_addPrice];
        [self.btn_addPrice setTitle:@"添加金额" forState:UIControlStateNormal];
        [self.btn_addPrice setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [self.btn_addPrice setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn_addPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(55);
        }];
        
        self.img1 = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img1];
        [self.img1 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_addPrice.mas_bottom);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        self.btn_zhekou = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_zhekou];
        [self.btn_zhekou setTitle:@"整单折扣" forState:UIControlStateNormal];
        [self.btn_zhekou setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [self.btn_zhekou setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn_zhekou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.img1.mas_bottom);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(55);
        }];
        
        self.img2 = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img2];
        [self.img2 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_zhekou.mas_bottom);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        
        self.btn_jianjia = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_jianjia];
        [self.btn_jianjia setTitle:@"整单减价" forState:UIControlStateNormal];
        [self.btn_jianjia setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        [self.btn_jianjia setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn_jianjia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.img2.mas_bottom);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(55);
        }];
        
        self.img3 = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img3];
        [self.img3 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_jianjia.mas_bottom);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        
        self.btn_mofen = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_mofen];
        [self.btn_mofen setTitle:@"抹分" forState:UIControlStateNormal];
        [self.btn_mofen setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn_mofen.layer.borderWidth = 0.5f;
        self.btn_mofen.layer.borderColor = [[UIColor colorWithHexString:@"#c2c2c2"] CGColor];
        self.btn_mofen.layer.cornerRadius = 3.0f;
        self.btn_mofen.layer.masksToBounds = YES;
        [self.btn_mofen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img3.mas_bottom).offset(18);
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(45);
        }];
        
        self.btn_mojiao = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_mojiao];
        [self.btn_mojiao setTitle:@"抹角" forState:UIControlStateNormal];
        [self.btn_mojiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn_mojiao.layer.borderWidth = 0.5f;
        self.btn_mojiao.layer.borderColor = [[UIColor colorWithHexString:@"#c2c2c2"] CGColor];
        self.btn_mojiao.layer.cornerRadius = 3.0f;
        self.btn_mojiao.layer.masksToBounds = YES;
        [self.btn_mojiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_mofen.mas_right).offset(30);
            make.top.equalTo(self.btn_mofen);
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(45);
        }];
        
        
    }
    return self;
}


@end
