//
//  ShopClassificationTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopClassificationTableViewCell.h"

@implementation ShopClassificationTableViewCell

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
            make.left.mas_equalTo(58);
            make.right.equalTo(self.mas_right).offset(-20);
            make.centerY.equalTo(self);
        }];
        [self.lab_name setTextColor:[UIColor blackColor]];
        self.lab_name.font = [UIFont systemFontOfSize:16];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
