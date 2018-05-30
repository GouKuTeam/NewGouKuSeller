//
//  EditInfoView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditInfoView.h"


@implementation EditInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lab_title = [[UILabel alloc]init];
        [self addSubview:self.lab_title];
        [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.height.equalTo(self);
        }];
        
        self.tf_detail = [[OttoTextField alloc]init];
        [self addSubview:self.tf_detail];
        [self.tf_detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(110);
            make.top.height.equalTo(self.lab_title);
            make.right.equalTo(self.mas_right).offset(-28);
        }];
        self.tf_detail.textColor = [UIColor colorWithHexString:@"#616161"];
        self.tf_detail.font = [UIFont systemFontOfSize:16];
        
        
        self.img_line = [[UIImageView alloc]init];
        [self addSubview:self.img_line];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(44);
            make.height.mas_equalTo(0.3);
            make.right.mas_equalTo(SCREEN_WIDTH - 14);
        }];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        
        self.img_jiantou = [[UIImageView alloc]init];
        [self addSubview:self.img_jiantou];
        [self.img_jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self.tf_detail);
            make.height.width.mas_equalTo(24);
        }];
        [self.img_jiantou setImage:[UIImage imageNamed:@"triangle_right"]];
        [self.img_jiantou setHidden:YES];
    }
    return self;
}

@end
