//
//  CustomCommoditySpecificationsTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/15.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CustomCommoditySpecificationsTableViewCell.h"

@implementation CustomCommoditySpecificationsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.lab_name = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(12);
            make.height.mas_equalTo(22);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        self.lab_name.textColor = [UIColor blackColor];
        self.lab_name.font = [UIFont systemFontOfSize:16];
        
        self.lab_price = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_price];
        [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_name);
            make.top.equalTo(self.lab_name.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
        }];
        self.lab_price.textColor = [UIColor colorWithHexString:@"#616161"];
        self.lab_price.font = [UIFont systemFontOfSize:14];
        
        self.lab_stock = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_stock];
        [self.lab_stock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_price.mas_right).offset(30);
            make.top.height.equalTo(self.lab_price);
            make.right.equalTo(self.mas_right).offset(-55);
        }];
        self.lab_stock.textColor = [UIColor colorWithHexString:@"#616161"];
        self.lab_stock.font = [UIFont systemFontOfSize:14];
        
        self.btn_delete = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_delete];
        [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 40);
            make.top.equalTo(self.lab_price);
            make.width.mas_equalTo(28);
            make.height.mas_equalTo(20);
        }];
        [self.btn_delete setTitle:@"删除" forState:UIControlStateNormal];
        [self.btn_delete setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        
        self.img_line = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_line];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(68);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.left.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
