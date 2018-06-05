//
//  ShopOrderManagerView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/5.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopOrderManagerView.h"

@implementation ShopOrderManagerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:COLOR_Main];
        
        NSArray  *arr_imageNormal = @[@"payment_unselected",@"distribution_unselected",@"cancel_white"];
        NSArray  *arr_imageSelected = @[@"payment_selected",@"distribution_selected",@"cancel_blue"];
        NSArray  *arr_title = @[@"新订单",@"待配送",@"取消订单"];
        
        self.arr_btn = [NSMutableArray array];
        self.arr_num = [NSMutableArray array];
        for (int i = 0; i < arr_title.count; i++) {
            UIButton *btn_demo = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/arr_title.count * i, SafeAreaStatusBarHeight,SCREEN_WIDTH/arr_title.count, 72)];
            [btn_demo setImage:[UIImage imageNamed:[arr_imageNormal objectAtIndex:i]] forState:UIControlStateNormal];
            [btn_demo setImage:[UIImage imageNamed:[arr_imageSelected objectAtIndex:i]] forState:UIControlStateSelected];
            [btn_demo setTitle:[arr_title objectAtIndex:i] forState:UIControlStateNormal];
            [btn_demo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn_demo setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateSelected];
            btn_demo.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_MEMO];
            [btn_demo setTitleEdgeInsets:UIEdgeInsetsMake(btn_demo.imageView.frame.size.height  ,-btn_demo.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
            [btn_demo setImageEdgeInsets:UIEdgeInsetsMake(-btn_demo.imageView.frame.size.height + 5, 0.0,0.0, -btn_demo.titleLabel.bounds.size.width)];//图片距离右边框
            [self addSubview:btn_demo];
            btn_demo.tag = i;
            [btn_demo addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.arr_btn addObject:btn_demo];
            
            UILabel  *lb_num = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/arr_title.count * i + SCREEN_WIDTH/arr_title.count/2 + 4, SafeAreaStatusBarHeight + 5, 16, 16)];
            [lb_num setBackgroundColor:[UIColor colorWithHexString:@"#E6670C"]];
            [lb_num setFont:[UIFont systemFontOfSize:FONT_SIZE_MEMO]];
            [lb_num setTextAlignment:NSTextAlignmentCenter];
            [lb_num setTextColor:[UIColor whiteColor]];
            [lb_num.layer setCornerRadius:8];
            lb_num.layer.masksToBounds = YES;
            [self addSubview:lb_num];
            [self.arr_num addObject:lb_num];
        }
        
    }
    return self;
}

- (void)setItemWithIndex:(NSInteger)index{
    for (UIButton *btn_demo in self.arr_btn) {
        [btn_demo setSelected:NO];
    }
    UIButton *btn_sender = [self.arr_btn objectAtIndex:index];
    [btn_sender setSelected:YES];
    if (self.selectType) {
        self.selectType(index);
    }
}

- (void)buttonAction:(UIButton *)btn_sender{
    for (UIButton *btn_demo in self.arr_btn) {
        [btn_demo setSelected:NO];
    }
    [btn_sender setSelected:YES];
    if (self.selectType) {
        self.selectType(btn_sender.tag);
    }
}
@end
