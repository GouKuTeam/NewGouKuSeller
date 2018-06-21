//
//  ShaiXuanView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/30.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShaiXuanView.h"

@implementation ShaiXuanView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:108 / 255.0 green:108 / 255.0 blue:108 / 255.0 alpha:1]];
        
        self.v_back = [[UIView alloc]init];
        [self addSubview:self.v_back];
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(SCREEN_HEIGHT - 160 - 68);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(160 + 68);
        }];
        self.v_back.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
        
        self.lab_titile = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_titile];
        [self.lab_titile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(20);
        }];
        [self.lab_titile setTextAlignment:NSTextAlignmentCenter];
        [self.lab_titile setText:@"选择类型"];
        [self.lab_titile setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_titile setFont:[UIFont systemFontOfSize:14]];
        
        self.btn_cha = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_cha];
        [self.btn_cha mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 32);
            make.top.mas_equalTo(15);
            make.width.height.mas_equalTo(17);
        }];
        [self.btn_cha setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        
        self.img_heng = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_heng];
        [self.img_heng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(60);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_heng setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        self.arr_btn = [[NSMutableArray alloc]init];
        self.arr_btnName = [NSArray arrayWithObjects:@"全部",@"销售结算",@"提现",@"充值",@"采购支付",@"采购退款", nil];
        CGFloat btnWidth = (SCREEN_WIDTH - 60) / 3;
        for (int i = 0; i < self.arr_btnName.count; i ++) {
            self.btn_all = [[UIButton alloc]init];
            [self.v_back addSubview:self.btn_all];
            [self.btn_all mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20 + (btnWidth + 10) * (i%3));
                make.top.mas_equalTo(self.img_heng.mas_bottom).offset(20 + i/3 * 57.8 + i/3 * 10);
                make.width.mas_equalTo(btnWidth);
                make.height.mas_equalTo(57.8);
            }];
            self.btn_all.tag = i;
            self.btn_all.layer.cornerRadius = 3.0f;
            self.btn_all.layer.masksToBounds = YES;
            [self.btn_all setTitle:[self.arr_btnName objectAtIndex:i] forState:UIControlStateNormal];
            [self.btn_all setBackgroundColor:[UIColor whiteColor]];
            [self.btn_all setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
            [self.btn_all setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
            if (i == 0) {
                [self.btn_all setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
                [self.btn_all setBackgroundColor:[UIColor colorWithHexString:@"#4167b2"]];
            }
            [self.btn_all addTarget:self action:@selector(btn_allAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.arr_btn addObject:self.btn_all];
        }
    }
    return self;
}

- (void)btn_allAction:(UIButton *)btn{
    for (UIButton *btn in self.arr_btn) {
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#4167b2"]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setHidden:YES];
    if (self.btnSelectIndex) {
        self.btnSelectIndex((int)btn.tag);
    }
}

@end
