//
//  NotBeginningActivityTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "NotBeginningActivityTableViewCell.h"

@implementation NotBeginningActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_activeName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_activeName];
        [self.lab_activeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(14);
            make.width.mas_equalTo(SCREEN_WIDTH - 80);
        }];
        [self.lab_activeName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_activeName setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_activeTime = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_activeTime];
        [self.lab_activeTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_activeName.mas_bottom).offset(5);
            make.left.equalTo(self.lab_activeName);
            make.width.mas_equalTo(SCREEN_WIDTH - 85);
        }];
        [self.lab_activeTime setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_activeTime setFont:[UIFont systemFontOfSize:13]];
        
        self.lab_activeStatus = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_activeStatus];
        [self.lab_activeStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 70);
            make.top.equalTo(self.lab_activeName);
            make.right.equalTo(self.mas_right).offset(-13);
        }];
        [self.lab_activeStatus setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_activeType = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_activeType];
        [self.lab_activeType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_activeStatus.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-13);
        }];
        [self.lab_activeType setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_activeType setFont:[UIFont systemFontOfSize:13]];
        
        
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
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_activeTime.mas_bottom).offset(10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(28);
        }];
        
        self.btn_stop = [[UIButton alloc]init];
        [self.contentView addSubview: self.btn_stop];
        [self.btn_stop setTitle:@"编辑" forState:UIControlStateNormal];
        self.btn_stop.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.btn_stop setTitleColor:[UIColor colorWithHexString:@"#4167b2"] forState:UIControlStateNormal];
        self.btn_stop.layer.borderWidth = 1;
        self.btn_stop.layer.borderColor = [[UIColor colorWithHexString:@"#4167b2"] CGColor];
        self.btn_stop.layer.cornerRadius = 3;
        self.btn_stop.layer.masksToBounds = YES;
        [self.btn_stop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_edit.mas_right).offset(17);
            make.top.equalTo(self.btn_edit);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(28);
        }];
        
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
