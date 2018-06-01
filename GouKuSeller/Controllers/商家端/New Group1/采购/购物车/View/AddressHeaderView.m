//
//  AddressHeaderView.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddressHeaderView.h"
#import "NSString+Size.h"

@implementation AddressHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.lb_name = [[UILabel alloc]init];
        [self.lb_name setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
        [self.lb_name setTextColor:[UIColor blackColor]];
        [self addSubview:self.lb_name];
        
        self.lb_phone = [[UILabel alloc]init];
        [self.lb_phone setTextColor:[UIColor blackColor]];
        [self.lb_phone setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
        [self.lb_phone setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lb_phone];
        
        self.lb_address = [[UILabel alloc]init];
        [self.lb_address setTextColor:[UIColor colorWithHexString:COLOR_TEXT_DESCGRAY]];
        [self.lb_address setNumberOfLines:0];
        [self.lb_address setFont:[UIFont systemFontOfSize:FONT_SIZE_MEMO]];
        [self addSubview:self.lb_address];
        
        self.iv_arrow = [[UIImageView alloc]init];
        [self.iv_arrow setImage:[UIImage imageNamed:@"triangle_right"]];
        [self addSubview:self.iv_arrow];
        
        [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(11);
            make.height.mas_equalTo(22);
            make.width.mas_equalTo(SCREEN_WIDTH - 160);
        }];
        
        [self.lb_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 145);
            make.width.mas_equalTo(110);
            make.top.height.equalTo(self.lb_name);
        }];
        
        [self.lb_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lb_name.mas_bottom).offset(7);
            make.left.equalTo(self.lb_name);
            make.width.mas_equalTo(SCREEN_WIDTH - 45);
            make.height.mas_lessThanOrEqualTo(44);
        }];
        
        [self.iv_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.left.mas_equalTo(SCREEN_WIDTH - 27);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}

- (void)contentCellWithAddressEntity:(AddressEntity *)addressEntity{
    self.lb_name.text = addressEntity.name;
    self.lb_phone.text = addressEntity.phone;
    self.lb_address.text = addressEntity.address;
    CGFloat height = [addressEntity.address fittingLabelHeightWithWidth:SCREEN_WIDTH - 45 andFontSize:[UIFont systemFontOfSize:FONT_SIZE_MEMO]];
    if (height > 32) {
        height = 32;
    }
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42 + height + 11)];
}

@end
