//
//  AddInventoryFooterView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddInventoryFooterView.h"

@implementation AddInventoryFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        UILabel *lab_heji = [[UILabel alloc]init];
        [self addSubview:lab_heji];
        [lab_heji setText:@"合计："];
        [lab_heji mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(14);
            make.height.mas_equalTo(20);
        }];
        
        self.lab_totalNum = [[UILabel alloc]init];
        [self addSubview:self.lab_totalNum];
        [self.lab_totalNum setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_totalNum setFont:[UIFont boldSystemFontOfSize:20]];
        [self.lab_totalNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lab_heji.mas_right).offset(3);
            make.top.mas_equalTo(13);
            make.height.mas_equalTo(22);
        }];
        
        self.btn_caogao = [[UIButton alloc]init];
        [self addSubview:self.btn_caogao];
        [self.btn_caogao setTitle:@"草稿" forState:UIControlStateNormal];
        [self.btn_caogao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_caogao.titleLabel.font = [UIFont systemFontOfSize:16];
        self.btn_caogao.backgroundColor = [UIColor colorWithHexString:@"#E57728"];
        [self.btn_caogao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 240);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(46);
        }];
        
        self.btn_tijiao = [[UIButton alloc]init];
        [self addSubview:self.btn_tijiao];
        [self.btn_tijiao setTitle:@"提交盘点" forState:UIControlStateNormal];
        [self.btn_tijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_tijiao.titleLabel.font = [UIFont systemFontOfSize:16];
        self.btn_tijiao.backgroundColor = [UIColor colorWithHexString:@"#4167B2"];
        [self.btn_tijiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 120);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(46);
        }];
    }
    return self;
}

@end
