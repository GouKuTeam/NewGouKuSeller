//
//  SupplierCommodityTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierCommodityTableViewCell.h"

@implementation SupplierCommodityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.img_pic = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_pic];
        [self.img_pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.width.height.mas_equalTo(72);
        }];
        
        self.lab_name = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor blackColor]];
        [self.lab_name setFont:[UIFont boldSystemFontOfSize:14]];
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_pic.mas_right).offset(10);
            make.top.equalTo(self.img_pic);
            make.height.mas_equalTo(16);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        self.lab_price = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_price];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lab_price setFont:[UIFont boldSystemFontOfSize:18]];
        [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_name);
            make.top.equalTo(self.lab_name.mas_bottom).offset(38);
            make.height.mas_equalTo(20);
        }];
        
        self.lab_priceGuiGe = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_priceGuiGe];
        [self.lab_priceGuiGe setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_priceGuiGe setFont:[UIFont systemFontOfSize:12]];
        [self.lab_priceGuiGe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_price.mas_right).offset(2);
            make.top.equalTo(self.lab_price);
            make.height.mas_equalTo(20);
        }];
        
        self.btn_addCommodity = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_addCommodity];
        [self.btn_addCommodity setImage:[UIImage imageNamed:@"addtocart"] forState:UIControlStateNormal];
        [self.btn_addCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_right).offset(-39);
            make.bottom.equalTo(self.img_pic.mas_bottom);
            make.width.height.mas_equalTo(22);
        }];
        
    }
    return self;
}

- (void)contentCellWithWareEntity:(SupplierCommodityEndity *)wareEntity{
    [self.img_pic sd_setImageWithURL:[NSURL URLWithString:wareEntity.pictures] placeholderImage:[UIImage imageNamed:@"headPic"]];
    [self.lab_name setText:wareEntity.name];
    [self.lab_price setText:[NSString stringWithFormat:@"¥%.2f",wareEntity.price]];
    [self.lab_priceGuiGe setText:[NSString stringWithFormat:@"/%@",wareEntity.unit]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
