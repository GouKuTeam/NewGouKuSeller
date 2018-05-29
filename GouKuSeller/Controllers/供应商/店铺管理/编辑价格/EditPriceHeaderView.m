//
//  EditPriceHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditPriceHeaderView.h"

@implementation EditPriceHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *v_line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [v_line1 setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self addSubview:v_line1];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 44)];
        [self addSubview:lab1];
        [lab1 setText:@"单位名称"];
        [lab1 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab1 setFont:[UIFont systemFontOfSize:16]];
        
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 13, 10, 30, 44)];
        [self addSubview:lab2];
        [lab2 setText:@"件"];
        [lab2 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab2 setFont:[UIFont systemFontOfSize:16]];
        [lab2 setTextAlignment:NSTextAlignmentRight];
        
        UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(15, lab2.bottom, 70, 44)];
        [self addSubview:lab3];
        [lab3 setText:@"是否启用"];
        [lab3 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab3 setFont:[UIFont systemFontOfSize:16]];
        
        self.v_switch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, lab2.bottom, 51, 31)];
        [self addSubview:self.v_switch];
        [self.v_switch setOnTintColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        self.v_switch.layer.anchorPoint = CGPointMake(0, 0.3);
        [self.v_switch setOn:YES animated:true];
        
        UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(15, lab3.bottom, 70, 44)];
        [self addSubview:lab4];
        [lab4 setText:@"价格"];
        [lab4 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [lab4 setFont:[UIFont systemFontOfSize:16]];
        
        self.tf_price = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 113, lab3.bottom, 100, 44)];
        [self addSubview:self.tf_price];
        [self.tf_price setPlaceholder:@"输入价格"];
        [self.tf_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.tf_price setFont:[UIFont systemFontOfSize:16]];
        [self.tf_price setTextAlignment:NSTextAlignmentRight];
        
        UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, lab1.bottom, SCREEN_WIDTH - 15, 0.5)];
        [self addSubview:img1];
        [img1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15,lab3.bottom, SCREEN_WIDTH - 15, 0.5)];
        [self addSubview:img2];
        [img2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
    }
    return self;
}

@end
