//
//  OrderListTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderListTableViewCell.h"
#import "DateUtils.h"

@implementation OrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.img_pay = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img_pay];
        [self.img_pay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.width.height.mas_equalTo(16);
        }];
        
        self.lab_price = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_price];
        [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_pay.mas_right).offset(12);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_price setFont:[UIFont systemFontOfSize:18]];
        
        
        self.lab_payTime = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_payTime];
        [self.lab_payTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 60);
            make.top.mas_equalTo(0);
            make.right.equalTo(self.mas_right).offset(-14);
            make.height.mas_equalTo(44);
        }];
        [self.lab_payTime setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_payTime setFont:[UIFont systemFontOfSize:16]];
        [self.lab_payTime setTextAlignment:NSTextAlignmentRight];
        
        self.lab_payStatus = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_payStatus];
        [self.lab_payStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 113);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        [self.lab_payStatus setTextColor:[UIColor colorWithHexString:@"#E6670C"]];
        [self.lab_payStatus setFont:[UIFont boldSystemFontOfSize:14]];
        [self.lab_payStatus setTextAlignment:NSTextAlignmentRight];
        
    }
    return self;
}

- (void)contentCellWithOrderListEntity:(OrderDetailEntity *)entity{
    if (entity.payType == 1) {
        [self.img_pay setImage:[UIImage imageNamed:@"payInGouku"]];
    }
    if (entity.payType == 2) {
        [self.img_pay setImage:[UIImage imageNamed:@"PayInCash"]];
    }
    [self.lab_price setText:[NSString stringWithFormat:@"¥%.2f",entity.payActual]];
    if (entity.status == 1) {
        //待支付  显示创建订单时间
        [self.lab_payTime setText:[DateUtils stringFromTimeInterval:entity.createAt formatter:@"HH:mm"]];
        [self.lab_payStatus setText:@"待支付"];
    }
    if (entity.status == 2) {
        //已完成  显示支付时间
        [self.lab_payTime setText:[DateUtils stringFromTimeInterval:entity.payAt formatter:@"HH:mm"]];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
