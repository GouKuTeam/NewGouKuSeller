//
//  ConfirmOrderTableViewCell.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ConfirmOrderTableViewCell.h"

@implementation ConfirmOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iv_image = [[UIImageView alloc]init];
        self.iv_image.clipsToBounds = YES;
        self.iv_image.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.iv_image];
        
        self.lb_name = [[UILabel alloc]init];
        [self.lb_name setFont:[UIFont systemFontOfSize:14]];
        [self.lb_name setTextColor:[UIColor blackColor]];
        [self.lb_name setNumberOfLines:0];
        [self addSubview:self.lb_name];
        
        self.lb_price = [[UILabel alloc]init];
        [self.lb_price setFont:[UIFont systemFontOfSize:14]];
        [self.lb_price setTextColor:[UIColor blackColor]];
        [self.lb_price setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lb_price];
        
        self.lb_specification = [[UILabel alloc]init];
        [self.lb_specification setFont:[UIFont systemFontOfSize:12]];
        [self.lb_specification setTextColor:[UIColor blackColor]];
        [self addSubview:self.lb_specification];
        
        self.lb_number = [[UILabel alloc]init];
        [self.lb_number setFont:[UIFont systemFontOfSize:12]];
        [self.lb_number setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lb_number setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lb_number];
        
        [self.iv_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.height.mas_equalTo(58);
            make.centerY.equalTo(self);
        }];
        
        [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iv_image.mas_right).offset(10);
            make.top.mas_equalTo(8);
            make.right.equalTo(self.mas_right).offset(-88);
            make.height.mas_lessThanOrEqualTo(36);
        }];
        
        [self.lb_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.mas_equalTo(11);
            make.height.mas_equalTo(16);
        }];
        
        [self.lb_specification mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lb_name);
            make.bottom.equalTo(self.iv_image.mas_bottom);
            make.height.mas_equalTo(16);
        }];
        
        [self.lb_number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.lb_price);
            make.top.equalTo(self.lb_price.mas_bottom).offset(4);
            make.height.mas_equalTo(14);
        }];
        
    }
    return self;
    
}

- (void)contentCellWithSupplierCommodityEndity:(SupplierCommodityEndity *)supplierCommodityEndity{
    [self.iv_image sd_setImageWithURL:[NSURL URLWithString:supplierCommodityEndity.pictures] placeholderImage:nil];
    [self.lb_name setText:supplierCommodityEndity.name];
    [self.lb_price setText:[NSString stringWithFormat:@"¥%.2f",supplierCommodityEndity.price]];
    [self.lb_number setText:[NSString stringWithFormat:@"x%d",(int)supplierCommodityEndity.count]];
    [self.lb_specification setText:supplierCommodityEndity.unit];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
