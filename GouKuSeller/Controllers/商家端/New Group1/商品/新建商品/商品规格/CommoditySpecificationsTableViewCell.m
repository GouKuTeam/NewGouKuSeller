//
//  CommoditySpecificationsTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/15.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommoditySpecificationsTableViewCell.h"

@implementation CommoditySpecificationsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.lab_title = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_title];
        [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.mas_right).offset(-15);
        }];
        [self.lab_title setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_title setFont:[UIFont systemFontOfSize:16]];
        
        self.img_line = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_line];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_title.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        
        self.ev_price = [[EditInfoView alloc]init];
        [self.contentView addSubview:self.ev_price];
        [self.ev_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_line.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        NSMutableAttributedString *str_price = [[NSMutableAttributedString alloc] initWithString:@"价格*"];
        [str_price addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#dc2e2e"] range:NSMakeRange(2,1)];
        [self.ev_price.lab_title setAttributedText:str_price];
        
        self.ev_stock = [[EditInfoView alloc]init];
        [self.contentView addSubview:self.ev_stock];
        [self.ev_stock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.ev_price.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        NSMutableAttributedString *str_stock = [[NSMutableAttributedString alloc] initWithString:@"库存*"];
        [str_stock addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#dc2e2e"] range:NSMakeRange(2,1)];
        [self.ev_stock.lab_title setAttributedText:str_stock];
        [self.ev_stock.tf_detail setPlaceholder:@"0"];
        
        self.ev_barcode = [[EditInfoView alloc]init];
        [self.contentView addSubview:self.ev_barcode];
        [self.ev_barcode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.ev_stock.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        
        self.ev_branchId = [[EditInfoView alloc]init];
        [self.contentView addSubview:self.ev_branchId];
        [self.ev_branchId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.ev_barcode.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
