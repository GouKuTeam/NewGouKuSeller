//
//  ShoppingInvalidTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/16.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShoppingInvalidTableViewCell.h"

@implementation ShoppingInvalidTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lb_status = [[UILabel alloc]init];
        [self.lb_status setFont:[UIFont systemFontOfSize:10]];
        [self.lb_status setTextColor:[UIColor whiteColor]];
        [self.lb_status setBackgroundColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lb_status.layer setCornerRadius:7];
        [self.lb_status.layer setMasksToBounds:YES];
        [self.lb_status setText:@"失效"];
        [self.lb_status setTextAlignment: NSTextAlignmentCenter];
        [self addSubview:self.lb_status];
        
        self.iv_image = [[UIImageView alloc]init];
        self.iv_image.clipsToBounds = YES;
        self.iv_image.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.iv_image];
        
        self.lb_name = [[UILabel alloc]init];
        [self.lb_name setFont:[UIFont systemFontOfSize:14]];
        [self.lb_name setTextColor:[UIColor blackColor]];
        [self.lb_name setNumberOfLines:0];
        [self addSubview:self.lb_name];
        
        self.lb_reason = [[UILabel alloc]init];
        [self.lb_reason setFont:[UIFont systemFontOfSize:12]];
        [self.lb_reason setTextColor:[UIColor blackColor]];
        [self addSubview:self.lb_reason];
        
        [self.lb_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(14);
        }];
        
        [self.iv_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lb_status.mas_right).offset(5);
            make.width.height.mas_equalTo(58);
            make.centerY.equalTo(self);
        }];
        
        [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iv_image.mas_right).offset(10);
            make.top.equalTo(self.iv_image);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        
        [self.lb_reason mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.lb_name);
            make.bottom.equalTo(self.iv_image.mas_bottom);
        }];
        
    }
    return self;
}

- (void)contentCellWithWareEntity:(SupplierCommodityEndity *)wareEntity{
    [self.iv_image sd_setImageWithURL:[NSURL URLWithString:wareEntity.pictures] placeholderImage:[UIImage imageNamed:@"headPic"]];
    [self.lb_name setText:wareEntity.name];
    [self.lb_reason setText:wareEntity.remark];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
