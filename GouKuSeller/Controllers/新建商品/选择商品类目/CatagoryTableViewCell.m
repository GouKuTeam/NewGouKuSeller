//
//  CatagoryTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/12.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CatagoryTableViewCell.h"

@implementation CatagoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_title = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_title];
        [self.lab_title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(44);
        }];
        [self.lab_title setFont:[UIFont systemFontOfSize:16]];
        [self.lab_title setTextColor:[UIColor blackColor]];
        
        
        self.img_line = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_line];
        [self.img_line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_title.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.2);
        }];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
