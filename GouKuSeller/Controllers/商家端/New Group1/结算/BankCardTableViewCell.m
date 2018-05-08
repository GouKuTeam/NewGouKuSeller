//
//  BankCardTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/28.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BankCardTableViewCell.h"

@implementation BankCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_title = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_title];
        [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.equalTo(self.lab_title);
            make.height.mas_equalTo(44);
        }];
        [self.lab_title setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_title setFont:[UIFont systemFontOfSize:16]];
        
        self.tf_detail = [[UITextField alloc]init];
        [self.contentView addSubview:self.tf_detail];
        [self.tf_detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(100);
            make.centerY.equalTo(self.tf_detail);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(44);
        }];
        self.tf_detail.textColor = [UIColor colorWithHexString:@"#000000"];
        [self.tf_detail setFont:[UIFont systemFontOfSize:16]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
