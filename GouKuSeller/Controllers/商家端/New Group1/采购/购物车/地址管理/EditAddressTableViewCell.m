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
            make.top.equalTo(self.lab_address.mas_bottom).offset(5);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        self.btn_morenAddress = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_morenAddress];
        [self.btn_morenAddress setTitle:@"默认地址" forState:UIControlStateNormal];
        [self.btn_morenAddress setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [self.btn_morenAddress setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [self.btn_morenAddress setContentMode:UIViewContentModeScaleAspectFill];
        self.btn_morenAddress.clipsToBounds = YES;
        self.btn_morenAddress.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_morenAddress setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
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
        [self.btn_delete setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_delete.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_delete setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
        self.btn_delete.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 48 - 17);
            make.top.equalTo(img_line.mas_bottom).offset(11);
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(20);
        }];
        
        self.btn_edit = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_edit];
        [self.btn_edit setTitle:@"编辑" forState:UIControlStateNormal];
        [self.btn_edit setImage:[UIImage imageNamed:@"addressedit"] forState:UIControlStateNormal];
        [self.btn_edit setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_edit.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_edit setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
        self.btn_edit.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.btn_edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 48 - 17 - 20 - 48);
            make.top.equalTo(img_line.mas_bottom).offset(11);
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(20);
        }];
        
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(0);
            make.bottom.equalTo(self.btn_delete.mas_bottom).offset(12);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(self.v_back.mas_bottom);
        }];
        
    }
    return self;
}

- (void)contentCellWithAddressEntity:(AddressEntity *)entity{
    [self.lab_name setText:entity.name];
    [self.lab_phone setText:entity.phone];
    [self.lab_address setText:entity.address];
    if (entity.isDefault == 1) {
        //是默认地址
        [self.btn_morenAddress setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }else{
        //非默认地址
        [self.btn_morenAddress setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
