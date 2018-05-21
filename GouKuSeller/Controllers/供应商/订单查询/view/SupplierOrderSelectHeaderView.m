//
//  SupplierOrderSelectHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierOrderSelectHeaderView.h"

@implementation SupplierOrderSelectHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:COLOR_Main];
        
        self.arr_btn = [NSMutableArray array];
        NSArray *arr_title = @[@"全部",@"进行中",@"已完成",@"已取消"];
        
        for (int i = 0; i < arr_title.count; i++) {
            UIButton *btn_sender = [[UIButton alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH/arr_title.count, 0, SCREEN_WIDTH/arr_title.count, 43)];
            [btn_sender setTitle:[arr_title objectAtIndex:i] forState:UIControlStateNormal];
            btn_sender.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_TITLE];
            [btn_sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn_sender setTitleColor:[UIColor colorWithHexString:@"#46A8FC"] forState:UIControlStateSelected];
            [btn_sender addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [btn_sender setSelected:YES];
            }
            btn_sender.tag = i;
            [self addSubview:btn_sender];
            [self.arr_btn addObject:btn_sender];
        }
        
        self.v_line = [[UIView alloc]initWithFrame:CGRectMake((CGFloat)(SCREEN_WIDTH/arr_title.count- 60)/2, 40, 60, 3)];
        [self.v_line setBackgroundColor:[UIColor colorWithHexString:@"#46A8FC"]];
        [self addSubview:self.v_line];
        
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
    [self.v_line setFrame:CGRectMake(btn_sender.left + (CGFloat)SCREEN_WIDTH/4/2 - 60/2, 40, 60, 3)];
}

@end
