//
//  EleMeBillTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EleMeBillTableViewCell.h"

@implementation EleMeBillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_xuhao = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_xuhao];
        [self.lab_xuhao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(17);
        }];
        [self.lab_xuhao setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_xuhao setFont:[UIFont systemFontOfSize:12]];
        [self.lab_xuhao setTextAlignment:NSTextAlignmentLeft];
        [self.lab_xuhao setText:@"#1"];
        
        self.lab_status = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_status];
        [self.lab_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15 + (SCREEN_WIDTH -30) / 3);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo((SCREEN_WIDTH -30) / 3);
            make.height.mas_equalTo(17);
        }];
        [self.lab_status setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_status setFont:[UIFont systemFontOfSize:12]];
        [self.lab_status setTextAlignment:NSTextAlignmentCenter];
        [self.lab_status setText:@"完成"];
        
        
        self.lab_price = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_price];
        [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 84 - 15);
            make.top.mas_equalTo(10);
            make.right.equalTo(self.mas_right).offset(-15);
            make.width.mas_equalTo(84);
//            make.height.mas_equalTo(17);
        }];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_price setFont:[UIFont systemFontOfSize:12]];
        [self.lab_price setTextAlignment:NSTextAlignmentCenter];
        [self.lab_price setText:@"133.00"];
        
        self.img_line = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_line];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(36.5);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
