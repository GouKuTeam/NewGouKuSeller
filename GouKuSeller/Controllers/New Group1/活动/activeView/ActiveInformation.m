//
//  ActiveInformation.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveInformation.h"

@implementation ActiveInformation

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.lab_activeName = [[UILabel alloc]init];
        [self addSubview:self.lab_activeName];
        [self.lab_activeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        [self.lab_activeName setText:@"活动名称"];
        [self.lab_activeName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_activeName setFont:[UIFont systemFontOfSize:16]];
        
        self.tf_activeName = [[UITextField alloc]init];
        [self addSubview:self.tf_activeName];
        [self.tf_activeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_activeName);
            make.right.equalTo(self.mas_right).offset(-16);
            make.left.equalTo(self.lab_activeName).offset(20);
            make.height.equalTo(self.lab_activeName);
        }];
        self.tf_activeName.textAlignment = NSTextAlignmentRight;
        [self.tf_activeName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.tf_activeName setFont:[UIFont systemFontOfSize:16]];
        [self.tf_activeName setPlaceholder:@"不超过十个字"];
        
        self.img_1 = [[UIImageView alloc]init];
        [self addSubview:self.img_1];
        [self.img_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_activeName.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_1 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        //开始日期
        self.lab_beginTime = [[UILabel alloc]init];
        [self addSubview:self.lab_beginTime];
        [self.lab_beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_1.mas_bottom);
            make.height.mas_equalTo(44);
        }];
        [self.lab_beginTime setText:@"开始日期"];
        [self.lab_beginTime setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_beginTime setFont:[UIFont systemFontOfSize:16]];
        
        self.btn_beginTime = [[UIButton alloc]init];
        [self addSubview:self.btn_beginTime];
        [self.btn_beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_beginTime);
            make.right.equalTo(self.mas_right).offset(-32);
            make.left.equalTo(self.lab_beginTime.mas_right).offset(20);
            make.height.equalTo(self.lab_activeName);
        }];
        [self.btn_beginTime setTitle:@"请选择开始日期" forState:UIControlStateNormal];
        [self.btn_beginTime setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
        self.btn_beginTime.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.btn_beginTime setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        
        self.img_jiantou1 = [[UIImageView alloc]init];
        [self addSubview:self.img_jiantou1];
        [self.img_jiantou1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_beginTime.mas_right).offset(10);
            make.top.equalTo(self.img_1.mas_bottom).offset(15.5);
        }];
        [self.img_jiantou1 setImage:[UIImage imageNamed:@"triangle_right"]];
        
        self.img_2 = [[UIImageView alloc]init];
        [self addSubview:self.img_2];
        [self.img_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_beginTime.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_2 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        //结束日期
        self.lab_endTime = [[UILabel alloc]init];
        [self addSubview:self.lab_endTime];
        [self.lab_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_2.mas_bottom);
            make.height.mas_equalTo(44);
        }];
        [self.lab_endTime setText:@"结束日期"];
        [self.lab_endTime setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_endTime setFont:[UIFont systemFontOfSize:16]];
        
        self.btn_endTime = [[UIButton alloc]init];
        [self addSubview:self.btn_endTime];
        [self.btn_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_endTime);
            make.right.equalTo(self.mas_right).offset(-32);
            make.left.equalTo(self.lab_endTime.mas_right).offset(20);
            make.height.equalTo(self.lab_activeName);
        }];
        [self.btn_endTime setTitle:@"请选择结束日期" forState:UIControlStateNormal];
        [self.btn_endTime setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
        self.btn_endTime.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.btn_endTime setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        
        
        self.img_jiantou2 = [[UIImageView alloc]init];
        [self addSubview:self.img_jiantou2];
        [self.img_jiantou2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_endTime.mas_right).offset(10);
            make.top.equalTo(self.img_2.mas_bottom).offset(15.5);
        }];
        [self.img_jiantou2 setImage:[UIImage imageNamed:@"triangle_right"]];
        
        self.img_3 = [[UIImageView alloc]init];
        [self addSubview:self.img_3];
        [self.img_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_endTime.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_3 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
//        //活动周
//        self.lab_beginTime = [[UILabel alloc]init];
//        [self addSubview:self.lab_beginTime];
//        [self.lab_beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(15);
//            make.top.equalTo(self.img_1.mas_bottom);
//            make.height.mas_equalTo(44);
//        }];
//        [self.lab_beginTime setText:@"开始日期"];
//        [self.lab_beginTime setTextColor:[UIColor colorWithHexString:@"#000000"]];
//        [self.lab_beginTime setFont:[UIFont systemFontOfSize:16]];
//
//        self.btn_beginTime = [[UIButton alloc]init];
//        [self addSubview:self.btn_beginTime];
//        [self.btn_beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.lab_beginTime);
//            make.right.equalTo(self.mas_right).offset(-32);
//            make.left.equalTo(self.lab_beginTime.mas_right).offset(20);
//            make.height.equalTo(self.lab_activeName);
//        }];
//        [self.btn_beginTime setTitle:@"请选择开始日期" forState:UIControlStateNormal];
//        [self.btn_beginTime setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
//        self.btn_beginTime.titleLabel.font = [UIFont systemFontOfSize:16];
//        [self.btn_beginTime setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//
//
//        self.img_jiantou1 = [[UIImageView alloc]init];
//        [self addSubview:self.img_jiantou1];
//        [self.img_jiantou1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.btn_beginTime.mas_right).offset(10);
//            make.top.equalTo(self.img_1.mas_bottom).offset(15.5);
//        }];
//        [self.img_jiantou1 setImage:[UIImage imageNamed:@"triangle_right"]];
//
//        self.img_2 = [[UIImageView alloc]init];
//        [self addSubview:self.img_2];
//        [self.img_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(15);
//            make.top.equalTo(self.lab_beginTime.mas_bottom);
//            make.width.mas_equalTo(SCREEN_WIDTH - 15);
//            make.height.mas_equalTo(0.5);
//        }];
//        [self.img_2 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        //结束日期
        self.lab_activeZhou = [[UILabel alloc]init];
        [self addSubview:self.lab_activeZhou];
        [self.lab_activeZhou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_3.mas_bottom);
            make.height.mas_equalTo(44);
        }];
        [self.lab_activeZhou setText:@"活动周"];
        [self.lab_activeZhou setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_activeZhou setFont:[UIFont systemFontOfSize:16]];
        
        self.btn_activeZhou = [[UIButton alloc]init];
        [self addSubview:self.btn_activeZhou];
        [self.btn_activeZhou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_activeZhou);
            make.right.equalTo(self.mas_right).offset(-32);
            make.left.equalTo(self.lab_activeZhou.mas_right).offset(20);
            make.height.equalTo(self.lab_activeZhou);
        }];
        [self.btn_activeZhou setTitle:@"请选择周" forState:UIControlStateNormal];
        [self.btn_activeZhou setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
        self.btn_activeZhou.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.btn_activeZhou setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        
        
        self.img_jiantou3 = [[UIImageView alloc]init];
        [self addSubview:self.img_jiantou3];
        [self.img_jiantou3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_activeZhou.mas_right).offset(10);
            make.top.equalTo(self.img_3.mas_bottom).offset(15.5);
        }];
        [self.img_jiantou3 setImage:[UIImage imageNamed:@"triangle_right"]];
        
        self.img_4 = [[UIImageView alloc]init];
        [self addSubview:self.img_4];
        [self.img_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_activeZhou.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_4 setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        //活动时段
        self.lab_activeTimeTitle = [[UILabel alloc]init];
        [self addSubview:self.lab_activeTimeTitle];
        [self.lab_activeTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_4.mas_bottom);
            make.height.mas_equalTo(44);
        }];
        [self.lab_activeTimeTitle setText:@"活动时段"];
        [self.lab_activeTimeTitle setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_activeTimeTitle setFont:[UIFont systemFontOfSize:16]];
        
        self.btn_activeTime = [[UIButton alloc]init];
        self.btn_activeTime.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
        [self addSubview:self.btn_activeTime];
        [self.btn_activeTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_activeTimeTitle);
            make.right.equalTo(self.mas_right).offset(-32);
            make.left.equalTo(self.lab_activeTimeTitle.mas_right).offset(20);
            make.height.equalTo(self.lab_activeTimeTitle);
        }];
        [self.btn_activeTime setTitle:@"请选择活动时段" forState:UIControlStateNormal];
        [self.btn_activeTime setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
        self.btn_activeTime.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.btn_activeTime setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        
        
        self.img_jiantou4 = [[UIImageView alloc]init];
        [self addSubview:self.img_jiantou4];
        [self.img_jiantou4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_activeTime.mas_right).offset(10);
            make.top.equalTo(self.img_4.mas_bottom).offset(15.5);
        }];
        [self.img_jiantou4 setImage:[UIImage imageNamed:@"triangle_right"]];
        
        
    }
    return self;
}

@end
