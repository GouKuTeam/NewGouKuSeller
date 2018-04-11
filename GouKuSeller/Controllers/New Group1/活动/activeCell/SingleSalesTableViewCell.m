//
//  SingleSalesTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SingleSalesTableViewCell.h"

@implementation SingleSalesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_commodityName = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_commodityName];
        [self.lab_commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16.5);
            make.top.mas_equalTo(14);
            make.right.equalTo(self.mas_right).offset(-14);
        }];
        [self.lab_commodityName setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_commodityName setFont:[UIFont systemFontOfSize:14]];
        self.lab_commodityName.numberOfLines = 0;
        
        self.lab_yuanjia = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_yuanjia];
        [self.lab_yuanjia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_commodityName);
            make.top.equalTo(self.lab_commodityName.mas_bottom).offset(5);
            make.height.mas_equalTo(32);
        }];
        [self.lab_yuanjia setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_yuanjia setFont:[UIFont systemFontOfSize:14]];
        
        self.btn_delete = [[UIButton alloc]init];
        [self.contentView addSubview:self.btn_delete];
        [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lab_yuanjia);
            make.right.equalTo(self.mas_right).offset(-17);
        }];
        [self.btn_delete setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        
        self.lab_ze = [[UILabel alloc]init];
        self.lab_ze.font = [UIFont systemFontOfSize:14];
        self.lab_ze.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.lab_ze];
        [self.lab_ze mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_commodityName.mas_bottom).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-46);
            make.height.mas_equalTo(32);
        }];
        
        self.tf_youhui = [[UITextField alloc]init];
        [self.contentView addSubview:self.tf_youhui];
        [self.tf_youhui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_commodityName.mas_bottom).offset(5);
            make.right.equalTo(self.lab_ze.mas_left);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(32);
        }];
        self.tf_youhui.layer.borderWidth = 0.5;
        self.tf_youhui.layer.cornerRadius = 2;
        self.tf_youhui.layer.masksToBounds = YES;
        self.tf_youhui.layer.borderColor = [[UIColor colorWithHexString:@"#c2c2c2"] CGColor];
        [self.tf_youhui setTextAlignment:NSTextAlignmentCenter];
        
        self.lab_youhui = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_youhui];
        [self.lab_youhui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.tf_youhui);
            make.right.equalTo(self.tf_youhui.mas_left).offset(-9);
//            make.left.lessThanOrEqualTo(self.lab_commodityName.mas_left).offset(10);
        }];
        self.lab_youhui.textAlignment = NSTextAlignmentRight;
        [self.lab_youhui setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_youhui setFont:[UIFont systemFontOfSize:14]];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(self.tf_youhui.mas_bottom).offset(13);
        }];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
