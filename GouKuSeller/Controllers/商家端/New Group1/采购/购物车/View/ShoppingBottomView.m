//
//  ShoppingBottomView.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShoppingBottomView.h"

@implementation ShoppingBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.btn_selectAll = [[UIButton alloc]initWithFrame:CGRectMake(10,frame.size.height/2 - 20/2, 56, 20)];
        [self.btn_selectAll setTitle:@"全选" forState:UIControlStateNormal];
        [self.btn_selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn_selectAll.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_DESC];
        [self.btn_selectAll setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [self.btn_selectAll setImage:[UIImage imageNamed:@"payComplete"] forState:UIControlStateSelected];
        self.btn_selectAll.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.btn_selectAll];
        
        self.lb_allPrice = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 133 - (SCREEN_WIDTH - 133 - 70), 0, SCREEN_WIDTH - 133 - 70, frame.size.height)];
        [self.lb_allPrice setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lb_allPrice setFont:[UIFont systemFontOfSize:18]];
        [self.lb_allPrice setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lb_allPrice];
        NSString *str_priceAll = @"合计：￥0.00";
        NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:str_priceAll];
        [str_amount addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, 3)];
        [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
        [self.lb_allPrice setAttributedText:str_amount];
        
        self.btn_checkout = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 0, 120, frame.size.height)];
        [self.btn_checkout setTitle:@"结算" forState:UIControlStateNormal];
        [self.btn_checkout setBackgroundColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN]];
        [self.btn_checkout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btn_checkout.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE_TITLE];
        [self addSubview:self.btn_checkout];
    }
    return self;
}

@end
