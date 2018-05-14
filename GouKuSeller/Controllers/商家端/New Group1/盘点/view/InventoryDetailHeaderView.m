//
//  InventoryDetailHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryDetailHeaderView.h"

@implementation InventoryDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        
        UIButton *btnStatus = [[UIButton alloc]init];
        [self addSubview:btnStatus];
        [btnStatus setBackgroundColor:[UIColor whiteColor]];
        [btnStatus setTitle:@"已调库" forState:UIControlStateNormal];
        [btnStatus setTitleColor:[UIColor colorWithHexString:@"#329702"] forState:UIControlStateNormal];
        btnStatus.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnStatus setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        [btnStatus setImageEdgeInsets:UIEdgeInsetsMake(0.0, -7, 0.0, 0.0)];
        [btnStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(40);
        }];
        
        UIView *v_time = [[UIView alloc]init];
        [self addSubview:v_time];
        [v_time setBackgroundColor:[UIColor whiteColor]];
        [v_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(btnStatus.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(88);
        }];
        
        UILabel *lab_cT = [[UILabel alloc]init];
        [v_time addSubview:lab_cT];
        [lab_cT setText:@"创建时间"];
        [lab_cT setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab_cT setFont:[UIFont systemFontOfSize:14]];
        [lab_cT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_createTime = [[UILabel alloc]init];
        [v_time addSubview:self.lab_createTime];
        [self.lab_createTime setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_createTime setFont:[UIFont systemFontOfSize:14]];
        [self.lab_createTime setTextAlignment:NSTextAlignmentRight];
        [self.lab_createTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 200);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(190);
            make.height.mas_equalTo(44);
        }];
        
        UILabel *lab_sT = [[UILabel alloc]init];
        [v_time addSubview:lab_sT];
        [lab_sT setText:@"提交时间"];
        [lab_sT setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab_sT setFont:[UIFont systemFontOfSize:14]];
        [lab_sT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(44);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_submitTime = [[UILabel alloc]init];
        [v_time addSubview:self.lab_submitTime];
        [self.lab_submitTime setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_submitTime setFont:[UIFont systemFontOfSize:14]];
        [self.lab_submitTime setTextAlignment:NSTextAlignmentRight];
        [self.lab_submitTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 200);
            make.top.mas_equalTo(44);
            make.width.mas_equalTo(190);
            make.height.mas_equalTo(44);
        }];
        
        UIImageView *img_line = [[UIImageView alloc]init];
        [v_time addSubview:img_line];
        [img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(44);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *v_commodity = [[UIView alloc]init];
        [self addSubview:v_commodity];
        [v_commodity setBackgroundColor:[UIColor whiteColor]];
        [v_commodity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(v_time);
            make.top.equalTo(v_time.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        
        UIImageView *img_line2 = [[UIImageView alloc]init];
        [v_commodity addSubview:img_line2];
        [img_line2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [img_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(43.5);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        self.lab_name = [[UILabel alloc]init];
        [v_commodity addSubview:self.lab_name];
        [self.lab_name setText:@"商品名称"];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:13]];
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(13);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(18);
        }];
        
        self.lab_stock = [[UILabel alloc]init];
        [v_commodity addSubview:self.lab_stock];
        [self.lab_stock setText:@"库存"];
        [self.lab_stock setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_stock setFont:[UIFont systemFontOfSize:13]];
        [self.lab_stock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 100);
            make.top.mas_equalTo(13);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(18);
        }];
        
        self.lab_inventoryNum = [[UILabel alloc]init];
        [v_commodity addSubview:self.lab_inventoryNum];
        [self.lab_inventoryNum setText:@"盘点数"];
        [self.lab_inventoryNum setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_inventoryNum setFont:[UIFont systemFontOfSize:13]];
        [self.lab_inventoryNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 50);
            make.top.mas_equalTo(13);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(18);
        }];
    }
    return self;
}
@end
