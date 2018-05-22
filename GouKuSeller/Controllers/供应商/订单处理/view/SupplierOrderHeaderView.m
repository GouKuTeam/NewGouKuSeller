//
//  SupplierOrderHeaderView.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierOrderHeaderView.h"
#import "NSString+Size.h"

@implementation SupplierOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:COLOR_Main];
        
        NSArray  *arr_imageNormal = @[@"payment_unselected",@"distribution_unselected"];
        NSArray  *arr_imageSelected = @[@"payment_selected",@"distribution_selected"];
        NSArray  *arr_title = @[@"待付款",@"待配送"];
        
        self.arr_btn = [NSMutableArray array];
        self.arr_num = [NSMutableArray array];
        for (int i = 0; i < arr_title.count; i++) {
            UIButton *btn_demo = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/arr_title.count * i, SafeAreaStatusBarHeight,SCREEN_WIDTH/arr_title.count, 72)];
            [btn_demo setImage:[arr_imageNormal objectAtIndex:i] forState:UIControlStateNormal];
            [btn_demo setImage:[arr_imageSelected objectAtIndex:i] forState:UIControlStateSelected];
            [btn_demo setTitle:[arr_title objectAtIndex:i] forState:UIControlStateNormal];
            [btn_demo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn_demo setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateSelected];
            btn_demo.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_MEMO];
            [self addSubview:btn_demo];
            btn_demo.tag = i;
            [btn_demo addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.arr_num addObject:btn_demo];
            
            UILabel  *lb_num = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/arr_title.count/2 + 11, 11, 18, 18)];
            [lb_num setBackgroundColor:[UIColor colorWithHexString:@"#FF3B30"]];
            [lb_num setFont:[UIFont systemFontOfSize:11]];
            [lb_num setTextColor:[UIColor whiteColor]];
            [lb_num.layer setCornerRadius:9];
            lb_num.layer.masksToBounds = YES;
            [self addSubview:lb_num];
            [self.arr_num addObject:lb_num];
        }
        
    }
    return self;
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
