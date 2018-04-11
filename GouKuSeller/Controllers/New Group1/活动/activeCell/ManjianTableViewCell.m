//
//  ManjianTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ManjianTableViewCell.h"

@implementation ManjianTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        int width = (SCREEN_WIDTH - 39 - 78 - 58) / 2;
        self.lab1 = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab1];
        [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(15);
            make.centerY.equalTo(self);
        }];
        [self.lab1 setText:@"满"];
        [self.lab1 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.lab1.font = [UIFont systemFontOfSize:14];
        
        self.tf_man = [[UITextField alloc]init];
        [self.contentView addSubview:self.tf_man];
        [self.tf_man mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab1.mas_right).offset(10);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(32);
            make.centerY.equalTo(self);
        }];
        self.tf_man.layer.borderWidth = 0.5;
        self.tf_man.layer.cornerRadius = 2;
        self.tf_man.layer.masksToBounds = YES;
        self.tf_man.layer.borderColor = [[UIColor colorWithHexString:@"#c2c2c2"] CGColor];
        self.tf_man.textAlignment = NSTextAlignmentCenter;
        
        self.lab2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab2];
        [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tf_man.mas_right).offset(10);
            make.centerY.equalTo(self);
        }];
        [self.lab2 setText:@"元，减"];
        [self.lab2 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.lab2.font = [UIFont systemFontOfSize:14];
        
        self.tf_jian = [[UITextField alloc]init];
        [self.contentView addSubview:self.tf_jian];
        [self.tf_jian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab2.mas_right).offset(10);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(32);
            make.centerY.equalTo(self);
        }];
        self.tf_jian.layer.borderWidth = 0.5;
        self.tf_jian.layer.cornerRadius = 2;
        self.tf_jian.layer.masksToBounds = YES;
        self.tf_jian.layer.borderColor = [[UIColor colorWithHexString:@"#c2c2c2"] CGColor];
        self.tf_jian.textAlignment = NSTextAlignmentCenter;

        
        self.lab3 = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab3];
        [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tf_jian.mas_right).offset(10);
            make.centerY.equalTo(self);
        }];
        [self.lab3 setText:@"元"];
        [self.lab3 setTextColor:[UIColor colorWithHexString:@"#000000"]];
        self.lab3.font = [UIFont systemFontOfSize:14];
        
        self.btn_delete = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_delete];
        [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab3.mas_right).offset(22);
            make.centerY.equalTo(self);
        }];
        [self.btn_delete setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
