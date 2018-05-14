//
//  InventoryDetailFooterView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryDetailFooterView.h"

@implementation InventoryDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *v1 = [[UIView alloc]init];
        [self addSubview:v1];
        [v1 setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(10);
        }];
        
        UIView *v2 = [[UIView alloc]init];
        [self addSubview:v2];
        [v2 setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [v2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(v1.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(66);
        }];
        
        UILabel *ying = [[UILabel alloc]init];
        [v2 addSubview:ying];
        [ying setText:@"整体盈"];
        [ying setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [ying setFont:[UIFont systemFontOfSize:14]];
        [ying setTextAlignment:NSTextAlignmentCenter];
        [ying mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(13);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *kui = [[UILabel alloc]init];
        [v2 addSubview:kui];
        [kui setText:@"整体亏"];
        [kui setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [kui setFont:[UIFont systemFontOfSize:14]];
        [kui setTextAlignment:NSTextAlignmentCenter];
        [kui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH / 2);
            make.top.mas_equalTo(13);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(20);
        }];
        
        self.lab_ying = [[UILabel alloc]init];
        [v2 addSubview:self.lab_ying];
        [self.lab_ying setTextColor:[UIColor colorWithHexString:@"#329702"]];
        [self.lab_ying setFont:[UIFont systemFontOfSize:16]];
        [self.lab_ying setTextAlignment:NSTextAlignmentCenter];
        [self.lab_ying mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(ying.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_kui = [[UILabel alloc]init];
        [v2 addSubview:self.lab_kui];
        [self.lab_kui setTextColor:[UIColor colorWithHexString:@"#D0021B "]];
        [self.lab_kui setFont:[UIFont systemFontOfSize:16]];
        [self.lab_kui setTextAlignment:NSTextAlignmentCenter];
        [self.lab_kui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH / 2);
            make.top.equalTo(kui.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(22);
        }];
    }
    return self;
}
@end
