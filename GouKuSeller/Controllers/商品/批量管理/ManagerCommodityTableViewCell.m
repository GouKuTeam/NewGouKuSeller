//
//  ManagerCommodityTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ManagerCommodityTableViewCell.h"

@implementation ManagerCommodityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.btn_select = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_select];
        [self.btn_select mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(36);
            make.width.height.mas_equalTo(20);
        }];
        [self.btn_select setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [self.btn_select setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        
        self.img_CommodityHeadPic = [[UIImageView alloc]init];
        self.img_CommodityHeadPic.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
        [self.contentView addSubview:self.img_CommodityHeadPic];
        [self.img_CommodityHeadPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(45);
            make.top.mas_equalTo(15);
            make.width.height.mas_equalTo(56);
        }];
        self.img_CommodityHeadPic.layer.cornerRadius = 3.0f;
        self.img_CommodityHeadPic.layer.masksToBounds = YES;
        
        
        self.lab_CommodityName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityName];
        [self.lab_CommodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_CommodityHeadPic.mas_right).offset(10);
            make.top.mas_equalTo(12);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        [self.lab_CommodityName setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_CommodityStock = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityStock];
        [self.lab_CommodityStock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityName);
            make.top.equalTo(self.lab_CommodityName.mas_bottom).offset(10);
        }];
        self.lab_CommodityStock.font = [UIFont systemFontOfSize:13];
        
        self.lab_CommoditySalesVolume = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommoditySalesVolume];
        [self.lab_CommoditySalesVolume mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityStock.mas_right).offset(13);
            make.top.equalTo(self.lab_CommodityStock);
            make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
        }];
        self.lab_CommoditySalesVolume.font = [UIFont systemFontOfSize:13];
        
        self.lab_CommodityPrice = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityPrice];
        [self.lab_CommodityPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityName);
            make.top.mas_equalTo(self.lab_CommodityStock.mas_bottom).offset(10);
            make.right.equalTo(self.lab_CommodityName);
        }];
        self.lab_CommodityPrice.font = [UIFont systemFontOfSize:16];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#e6670c"]];
        
        self.img_line = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_line];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_CommodityHeadPic);
            make.top.equalTo(self.lab_CommodityPrice.mas_bottom).offset(11);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)contentCellWithCommodityInformationEntity:(CommodityInformationEntity *)commodityInformationEntity{
    self.lab_CommodityName.text = commodityInformationEntity.name;
    self.lab_CommodityStock.text = [NSString stringWithFormat:@"库存%@",commodityInformationEntity.stock];
    self.lab_CommoditySalesVolume.text = [NSString stringWithFormat:@"月售%@",commodityInformationEntity.saleAmountMonth];
    self.lab_CommodityPrice.text = [NSString stringWithFormat:@"￥%.2f",commodityInformationEntity.price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
