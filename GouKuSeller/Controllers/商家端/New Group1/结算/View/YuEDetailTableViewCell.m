//
//  YuEDetailTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/30.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "YuEDetailTableViewCell.h"

@implementation YuEDetailTableViewCell

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
            make.left.mas_equalTo(11);
            make.top.mas_equalTo(12);
            make.height.mas_equalTo(22);
        }];
        [self.lab_title setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_title setFont:[UIFont systemFontOfSize:16]];
        
        
        
        self.lab_time = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_time];
        [self.lab_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(11);
            make.top.equalTo(self.lab_title.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
        }];
        [self.lab_time setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_time setFont:[UIFont systemFontOfSize:14]];
//        [self.lab_time setText:@"2018-01-01 12:00:00"];
        
        
        self.lab_price = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_price];
        [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(150);
            make.top.mas_equalTo(12);
            make.right.equalTo(self.mas_right).offset(-11);
            make.height.mas_equalTo(25);
        }];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_price setFont:[UIFont systemFontOfSize:18]];
        [self.lab_price setTextAlignment:NSTextAlignmentRight];
//        [self.lab_price setText:@"+200.00"];
        
       
    }
    return self;
}

- (void)contentCellWithAccountCashDetailEntity:(AccountCashDetailEntity *)accountCashDetailEntity{
   
    if (accountCashDetailEntity.accountType == 2) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.lab_price mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(150);
            make.top.mas_equalTo(12);
            make.right.equalTo(self.mas_right).offset(-40);
            make.height.mas_equalTo(25);
        }];
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
        [self.lab_price mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(150);
            make.top.mas_equalTo(10);
            make.right.equalTo(self.mas_right).offset(-13);
            make.height.mas_equalTo(25);
        }];
    }
    [self.lab_title setText:accountCashDetailEntity.accountName];
    [self.lab_time setText:accountCashDetailEntity.date];
    [self.lab_price setText:[NSString stringWithFormat:@"%.2f",accountCashDetailEntity.accountNum]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
