//
//  SearchWithNameTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SearchWithNameTableViewCell.h"

@implementation SearchWithNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.img_CommodityHeadPic = [[UIImageView alloc]init];
        self.img_CommodityHeadPic.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_BG];
        [self.contentView addSubview:self.img_CommodityHeadPic];
        [self.img_CommodityHeadPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(15);
            make.width.height.mas_equalTo(56);
        }];
        self.img_CommodityHeadPic.layer.cornerRadius = 3.0f;
        self.img_CommodityHeadPic.layer.masksToBounds = YES;
        
        self.lab_CommodityName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityName];
        [self.lab_CommodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_CommodityHeadPic.mas_right).offset(10);
            make.top.mas_equalTo(12);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        [self.lab_CommodityName setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_CommodityStock = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityStock];
        [self.lab_CommodityStock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityName);
            make.top.equalTo(self.lab_CommodityName.mas_bottom).offset(5);
        }];
        self.lab_CommodityStock.font = [UIFont systemFontOfSize:13];
        
        self.lab_CommoditySalesVolume = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommoditySalesVolume];
        [self.lab_CommoditySalesVolume mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityStock.mas_right).offset(13);
            make.top.equalTo(self.lab_CommodityStock);
            make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
        }];
        self.lab_CommoditySalesVolume.font = [UIFont systemFontOfSize:13];
        
        self.lab_CommodityPrice = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_CommodityPrice];
        [self.lab_CommodityPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_CommodityName);
            make.top.mas_equalTo(self.lab_CommodityStock.mas_bottom).offset(5);
            make.right.equalTo(self.lab_CommodityName);
        }];
        self.lab_CommodityPrice.font = [UIFont systemFontOfSize:16];
        [self.lab_CommodityPrice setTextColor:[UIColor colorWithHexString:@"#e6670c"]];
        
        self.btn_more = [[UIButton alloc]init];
        [self.btn_more setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [self.contentView addSubview: self.btn_more];
        self.btn_more.layer.borderWidth = 1;
        self.btn_more.layer.borderColor = [[UIColor colorWithHexString:@"#4167b2"] CGColor];
        self.btn_more.layer.cornerRadius = 3;
        self.btn_more.layer.masksToBounds = YES;
        [self.btn_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.width.mas_equalTo(50);
            make.top.equalTo(self.lab_CommodityPrice.mas_bottom).offset(11);
            make.height.mas_equalTo(28);
        }];
        
        self.btn_edit = [[UIButton alloc]init];
        [self.contentView addSubview: self.btn_edit];
        [self.btn_edit setTitle:@"编辑" forState:UIControlStateNormal];
        self.btn_edit.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_edit setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_edit.layer.borderWidth = 1;
        self.btn_edit.layer.borderColor = [[UIColor colorWithHexString:@"#4167b2"] CGColor];
        self.btn_edit.layer.cornerRadius = 3;
        self.btn_edit.layer.masksToBounds = YES;
        [self.btn_edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self.btn_more);
            make.right.equalTo(self.btn_more.mas_left).offset(-15);
            make.width.mas_equalTo(70);
        }];
        
        self.img_line = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_line];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.equalTo(self.btn_edit.mas_bottom).offset(14);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
        }];
        
        self.v_back = [[UIView alloc]init];
        [self.v_back setHidden:YES];
        self.v_back.clipsToBounds = YES;
        self.v_back.layer.cornerRadius = 3;
        self.v_back.layer.masksToBounds = YES;
        self.v_back.layer.borderColor = [[UIColor colorWithHexString:@"#d8d8d8"] CGColor];
        self.v_back.layer.borderWidth = 0.5;
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.v_back];
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_edit.mas_left).offset(14);
            make.top.equalTo(self.btn_edit.mas_bottom).offset(2);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(88);
        }];
        
        self.img_mid_line = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_mid_line];
        [self.img_mid_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(44);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_mid_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
        self.btn_xiajia = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_xiajia];
        [self.btn_xiajia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(44);
        }];
        [self.btn_xiajia setTitle:@"下架" forState:UIControlStateNormal];
        self.btn_xiajia.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_xiajia setTitleColor:[UIColor colorWithHexString:@"4167b2"] forState:UIControlStateNormal];
        
        self.btn_delege = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_delege];
        [self.btn_delege mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(44);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(44);
        }];
        [self.btn_delege setTitle:@"删除" forState:UIControlStateNormal];
        self.btn_delege.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_delege setTitleColor:[UIColor colorWithHexString:@"4167b2"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
