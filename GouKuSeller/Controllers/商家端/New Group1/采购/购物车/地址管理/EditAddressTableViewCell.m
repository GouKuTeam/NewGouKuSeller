//
//  EditAddressTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditAddressTableViewCell.h"

@implementation EditAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        self.v_back = [[UIView alloc]init];
        [self.contentView addSubview:self.v_back];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        
        self.lab_name = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:16]];
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(11);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_phone = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_phone];
        [self.lab_phone setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_phone setTextAlignment:NSTextAlignmentRight];
        [self.lab_phone setFont:[UIFont systemFontOfSize:16]];
        [self.lab_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 150);
            make.top.equalTo(self.lab_name);
            make.right.equalTo(self.mas_right).offset(-13);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_address = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_address];
        [self.lab_address setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_address setFont:[UIFont systemFontOfSize:11]];
        self.lab_address.numberOfLines = 0;
        [self.lab_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.lab_name.mas_bottom).offset(9);
        }];
        
        UIImageView *img_line = [[UIImageView alloc]init];
        [self.v_back addSubview:img_line];
        [img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_address.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        self.btn_morenAddress = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_morenAddress];
        [self.btn_morenAddress setTitle:@"默认地址" forState:UIControlStateNormal];
        [self.btn_morenAddress setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [self.btn_morenAddress setImageEdgeInsets:UIEdgeInsetsMake(0.0, -8.5, 0.0, 0.0)];
        self.btn_morenAddress.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.btn_morenAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15.5);
            make.top.equalTo(img_line.mas_bottom).offset(11);
            make.width.mas_equalTo(85);
            make.height.mas_equalTo(20);
        }];
        
        
        self.btn_delete = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_delete];
        [self.btn_delete setTitle:@"删除" forState:UIControlStateNormal];
        [self.btn_delete setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.btn_delete setImageEdgeInsets:UIEdgeInsetsMake(0.0, -8, 0.0, 0.0)];
        self.btn_delete.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 48 - 17);
            make.top.equalTo(img_line.mas_bottom).offset(11);
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(20);
        }];
        
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(0);
            make.height.equalTo(self.btn_delete.mas_bottom).offset(12);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
