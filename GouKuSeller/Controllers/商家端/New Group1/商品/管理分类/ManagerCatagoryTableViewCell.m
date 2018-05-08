//
//  ManagerCatagoryTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ManagerCatagoryTableViewCell.h"

@implementation ManagerCatagoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        [self setBackgroundColor:[UIColor yellowColor]];
//        self.img_jiantou = [[UIImageView alloc]init];
//        [self.contentView addSubview:self.img_jiantou];
//        [self.img_jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.mas_equalTo(19);
//            make.width.mas_equalTo(10);
//            make.height.mas_equalTo(11);
//        }];
//        [self.img_jiantou setImage:[UIImage imageNamed:@"triangle_left"]];
        
        
        self.lab_catagoryName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_catagoryName];
        [self.lab_catagoryName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(58);
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-100);
        }];
        
        self.btn_edit = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_edit];
        [self.btn_edit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 55);
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-15);
            
        }];
        [self.btn_edit setTitle:@"编辑" forState:UIControlStateNormal];
        [self.btn_edit setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_edit.titleLabel.font = [UIFont systemFontOfSize:16];
        
        self.img_line = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_line];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(44);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#d8d8d8"]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
