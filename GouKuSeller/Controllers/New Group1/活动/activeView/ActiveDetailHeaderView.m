//
//  ActiveDetailHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveDetailHeaderView.h"

@implementation ActiveDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lab_status = [[UILabel alloc]init];
        [self addSubview:self.lab_status];
        [self.lab_status setBackgroundColor:[UIColor whiteColor]];
        self.lab_status.textAlignment = NSTextAlignmentCenter;
        self.lab_status.font = [UIFont boldSystemFontOfSize:16];
        [self.lab_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        
        self.v_detailBack = [[UIView alloc]init];
        [self addSubview:self.v_detailBack];
        [self.v_detailBack setBackgroundColor:[UIColor whiteColor]];
        [self.v_detailBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_status);
            make.top.equalTo(self.lab_status.mas_bottom).offset(8);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(220);
        }];
        
        UILabel *labName = [[UILabel alloc]init];
        [self.v_detailBack addSubview:labName];
        [labName setText:@"活动名称"];
        [labName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [labName setFont:[UIFont systemFontOfSize:16]];
        [labName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_actName = [[UILabel alloc]init];
        [self.v_detailBack addSubview:self.lab_actName];
        [self.lab_actName setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_actName setFont:[UIFont systemFontOfSize:16]];
        self.lab_actName.textAlignment = NSTextAlignmentRight;
        [self.lab_actName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(85);
            make.top.height.equalTo(labName);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        
        UILabel *labbegtime = [[UILabel alloc]init];
        [self.v_detailBack addSubview:labbegtime];
        [labbegtime setText:@"开始日期"];
        [labbegtime setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [labbegtime setFont:[UIFont systemFontOfSize:16]];
        [labbegtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(labName.mas_bottom);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_beginTime = [[UILabel alloc]init];
        [self.v_detailBack addSubview:self.lab_beginTime];
        [self.lab_beginTime setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_beginTime setFont:[UIFont systemFontOfSize:16]];
        self.lab_beginTime.textAlignment = NSTextAlignmentRight;
        [self.lab_beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(85);
            make.top.height.equalTo(labbegtime);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        UILabel *labendtime = [[UILabel alloc]init];
        [self.v_detailBack addSubview:labendtime];
        [labendtime setText:@"结束日期"];
        [labendtime setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [labendtime setFont:[UIFont systemFontOfSize:16]];
        [labendtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(labbegtime.mas_bottom);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_endTime = [[UILabel alloc]init];
        [self.v_detailBack addSubview:self.lab_endTime];
        [self.lab_endTime setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_endTime setFont:[UIFont systemFontOfSize:16]];
        self.lab_endTime.textAlignment = NSTextAlignmentRight;
        [self.lab_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(85);
            make.top.height.equalTo(labendtime);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        UILabel *labActWeek = [[UILabel alloc]init];
        [self.v_detailBack addSubview:labActWeek];
        [labActWeek setText:@"活动周"];
        [labActWeek setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [labActWeek setFont:[UIFont systemFontOfSize:16]];
        [labActWeek mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(labendtime.mas_bottom);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_actWeek = [[UILabel alloc]init];
        [self.v_detailBack addSubview:self.lab_actWeek];
        [self.lab_actWeek setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_actWeek setFont:[UIFont systemFontOfSize:16]];
        self.lab_actWeek.textAlignment = NSTextAlignmentRight;
        [self.lab_actWeek mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(85);
            make.top.height.equalTo(labActWeek);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        
        UILabel *labActTime = [[UILabel alloc]init];
        [self.v_detailBack addSubview:labActTime];
        [labActTime setText:@"活动时段"];
        [labActTime setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [labActTime setFont:[UIFont systemFontOfSize:16]];
        [labActTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(labActWeek.mas_bottom);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_actTime = [[UILabel alloc]init];
        [self.v_detailBack addSubview:self.lab_actTime];
        [self.lab_actTime setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_actTime setFont:[UIFont systemFontOfSize:16]];
        self.lab_actTime.textAlignment = NSTextAlignmentRight;
        [self.lab_actTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(85);
            make.top.height.equalTo(labActTime);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        UIImageView *imgline1 = [[UIImageView alloc]init];
        [self.v_detailBack addSubview:imgline1];
        [imgline1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [imgline1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(44);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView *imgline2 = [[UIImageView alloc]init];
        [self.v_detailBack addSubview:imgline2];
        [imgline2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [imgline2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(44 * 2);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView *imgline3 = [[UIImageView alloc]init];
        [self.v_detailBack addSubview:imgline3];
        [imgline3 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [imgline3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(44 * 3);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView *imgline4 = [[UIImageView alloc]init];
        [self.v_detailBack addSubview:imgline4];
        [imgline4 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [imgline4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(44 * 4);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *v_typeBack = [[UIView alloc]init];
        [self addSubview:v_typeBack];
        [v_typeBack setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [v_typeBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_detailBack.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(40);
        }];
        
        self.lab_actType = [[UILabel alloc]init];
        [v_typeBack addSubview:self.lab_actType];
        [self.lab_actType setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_actType setFont:[UIFont systemFontOfSize:14]];
        [self.lab_actType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
    }
    return self;
}

@end
