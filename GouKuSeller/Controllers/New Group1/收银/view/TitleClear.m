//
//  TitleClear.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "TitleClear.h"

@implementation TitleClear

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.5]];
        self.v_back = [[UIView alloc]init];
        [self addSubview:self.v_back];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(50);
        }];
        
        self.btn_clear = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_clear];
        [self.btn_clear setTitle:@"清空商品" forState:UIControlStateNormal];
        [self.btn_clear setTitleColor:[UIColor colorWithHexString:@"#dc2e2e"] forState:UIControlStateNormal];
        self.btn_clear.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.btn_clear mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}
@end
