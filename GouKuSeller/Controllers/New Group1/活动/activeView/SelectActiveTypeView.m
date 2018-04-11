//
//  SelectActiveTypeView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectActiveTypeView.h"

@implementation SelectActiveTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lab_title1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 26, 100, 22)];
        [self addSubview:self.lab_title1];
        [self.lab_title1 setText:@"满减活动"];
        [self.lab_title1 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_title1 setFont:[UIFont systemFontOfSize:16]];
        
        self.btn_manjian = [[UIButton alloc]initWithFrame:CGRectMake(15, 59, (SCREEN_WIDTH - 45) / 2 , 60)];
        [self addSubview:self.btn_manjian];
        [self.btn_manjian setTitle:@"满减" forState:UIControlStateNormal];
        [self.btn_manjian setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [self.btn_manjian setBackgroundColor:[UIColor whiteColor]];
        self.btn_manjian.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.lab_title2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 149, 100, 22)];
        [self addSubview:self.lab_title2];
        [self.lab_title2 setText:@"单品活动"];
        [self.lab_title2 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_title2 setFont:[UIFont systemFontOfSize:16]];
        
        self.btn_zhekou = [[UIButton alloc]initWithFrame:CGRectMake(15, 184, (SCREEN_WIDTH - 45) / 2 , 60)];
        [self addSubview:self.btn_zhekou];
        [self.btn_zhekou setTitle:@"折扣" forState:UIControlStateNormal];
        [self.btn_zhekou setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [self.btn_zhekou setBackgroundColor:[UIColor whiteColor]];
        self.btn_zhekou.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.btn_tejia = [[UIButton alloc]initWithFrame:CGRectMake(30 + (SCREEN_WIDTH - 45) / 2, 184, (SCREEN_WIDTH - 45) / 2 , 60)];
        [self addSubview:self.btn_tejia];
        [self.btn_tejia setTitle:@"特价" forState:UIControlStateNormal];
        [self.btn_tejia setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [self.btn_tejia setBackgroundColor:[UIColor whiteColor]];
        self.btn_tejia.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.btn_lijian = [[UIButton alloc]initWithFrame:CGRectMake(15, 264, (SCREEN_WIDTH - 45) / 2 , 60)];
        [self addSubview:self.btn_lijian];
        [self.btn_lijian setTitle:@"立减" forState:UIControlStateNormal];
        [self.btn_lijian setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [self.btn_lijian setBackgroundColor:[UIColor whiteColor]];
        self.btn_lijian.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.lab_title3 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, SCREEN_WIDTH, 20)];
        [self addSubview:self.lab_title3];
        [self.lab_title3 setText:@"满减活动和单品活动不能同享"];
        [self.lab_title3 setTextColor:[UIColor colorWithHexString:@"#616161"]];
        self.lab_title3.font = [UIFont systemFontOfSize:14];
        self.lab_title3.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
