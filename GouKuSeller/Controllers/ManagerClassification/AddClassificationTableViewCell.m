//
//  AddClassificationTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddClassificationTableViewCell.h"

@implementation AddClassificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_CName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CName];
        [self.lab_CName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        [self.lab_CName setText:@"分类名称"];
        [self.lab_CName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.lab_CName.font = [UIFont systemFontOfSize:16];
        
        self.tef_CName = [[UITextField alloc]init];
        [self.contentView addSubview:self.tef_CName];
        [self.tef_CName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CName);
            make.top.mas_equalTo(0);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(self.lab_CName);
        }];
        self.tef_CName.font = [UIFont systemFontOfSize:16];
        self.tef_CName.textColor = [UIColor colorWithHexString:@"#000000"];
        self.tef_CName.placeholder = @"填写分类名称";
        self.tef_CName.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
