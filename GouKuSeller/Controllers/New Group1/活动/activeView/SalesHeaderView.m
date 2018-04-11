//
//  NewSearchDoctorHeaderView.m
//  DocChat-C-iphone
//
//  Created by lixiao on 2017/12/14.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import "SalesHeaderView.h"

@implementation SalesHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:COLOR_Main];
        
        self.arr_btn = [NSMutableArray array];
        
        UIButton  *btn_doctor = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (CGFloat)SCREEN_WIDTH/3, 40)];
        [btn_doctor setTitle:@"未开始" forState:UIControlStateNormal];
        btn_doctor.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn_doctor setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_doctor setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateSelected];
        [btn_doctor addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn_doctor setSelected:YES];
        btn_doctor.tag = 1;
        [self addSubview:btn_doctor];
        [self.arr_btn addObject:btn_doctor];
        
        UIButton  *btn_hospital = [[UIButton alloc]initWithFrame:CGRectMake((CGFloat)SCREEN_WIDTH/3, 0, (CGFloat)SCREEN_WIDTH/3, 40)];
        [btn_hospital setTitle:@"进行中" forState:UIControlStateNormal];
        btn_hospital.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn_hospital setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_hospital setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateSelected];
        [btn_hospital addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        btn_hospital.tag = 2;
        [self addSubview:btn_hospital];
        [self.arr_btn addObject:btn_hospital];
        
        UIButton  *btn_department = [[UIButton alloc]initWithFrame:CGRectMake((CGFloat)SCREEN_WIDTH/3 * 2, 0, (CGFloat)SCREEN_WIDTH/3, 40)];
        [btn_department setTitle:@"已停止" forState:UIControlStateNormal];
        btn_department.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn_department setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_department setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateSelected];
        btn_department.tag = 3;
        [btn_department addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:btn_department];
        [self.arr_btn addObject:btn_department];
        
        self.v_line = [[UIView alloc]initWithFrame:CGRectMake((CGFloat)SCREEN_WIDTH/3/2 - 60/2, 37, 60, 3)];
        [self.v_line setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        [self addSubview:self.v_line];
        
        UIView  *v_lineGray = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
        [v_lineGray setBackgroundColor:[UIColor colorWithHexString:COLOR_LINE_LIGHTGRAY]];
        [self addSubview:v_lineGray];
        
    }
    return self;
}

- (void)selectAction:(UIButton *)btn_sender{
    for (UIButton *btn_demo in self.arr_btn) {
        [btn_demo setSelected:NO];
    }
    [btn_sender setSelected:YES];
    if (self.selectItem) {
        self.selectItem((int)btn_sender.tag);
    }
    [self.v_line setFrame:CGRectMake(btn_sender.left + (CGFloat)SCREEN_WIDTH/3/2 - 60/2, 38, 60, 2)];
}

@end
