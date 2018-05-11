//
//  CustomerManagerTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CustomerManagerTableViewCell.h"

@implementation CustomerManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.img_touxiang = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_touxiang];
        self.img_touxiang.layer.cornerRadius = 2.0f;
        [self.img_touxiang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.width.height.mas_equalTo(50);
        }];
        
        self.lab_shopName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_shopName];
        [self.lab_shopName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_shopName setFont:[UIFont systemFontOfSize:16]];
        [self.lab_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_touxiang.mas_right).offset(10);
            make.top.mas_equalTo(14);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_personName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_personName];
        [self.lab_personName setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_personName setFont:[UIFont systemFontOfSize:14]];
        [self.lab_personName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_shopName);
            make.top.equalTo(self.lab_shopName.mas_bottom).offset(1);
            make.height.mas_equalTo(20);
        }];
        
    }
    return self;
}

- (void)contentCellWithCustomerManagerEntity:(CustomerManagerEntity *)entity{
    [self.img_touxiang sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HeadQZ,entity.logo]] placeholderImage:[UIImage imageNamed:@"headPic"]];
    [self.lab_shopName setText:entity.shopName];
    [self.lab_personName setText:entity.personName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
