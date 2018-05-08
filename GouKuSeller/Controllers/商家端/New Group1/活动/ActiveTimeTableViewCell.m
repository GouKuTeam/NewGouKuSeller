//
//  ActiveTimeTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/27.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveTimeTableViewCell.h"

@implementation ActiveTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.btn_beginTime = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_beginTime];
        [self.btn_beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(44);
            make.centerY.equalTo(self);
        }];
        [self.btn_beginTime setTitle:@"开始时间" forState:UIControlStateNormal];
        [self.btn_beginTime setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
        self.btn_beginTime.titleLabel.font = [UIFont systemFontOfSize:16];
        
        self.img_heng = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_heng];
        [self.img_heng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(113);
            make.top.mas_equalTo(22);
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_heng setBackgroundColor:[UIColor colorWithHexString:@"#979797"]];
        
        self.btn_endTime = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_endTime];
        [self.btn_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(133);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(44);
            make.centerY.equalTo(self);
        }];
        [self.btn_endTime setTitle:@"结束时间" forState:UIControlStateNormal];
        [self.btn_endTime setTitleColor:[UIColor colorWithHexString:@"#c2c2c2"] forState:UIControlStateNormal];
        self.btn_endTime.titleLabel.font = [UIFont systemFontOfSize:16];
        
        self.btn_delete = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_delete];
        [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 31);
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
