//
//  SupplierOrderManagerTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierOrderManagerTableViewCell.h"

@implementation SupplierOrderManagerTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_price = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_price];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_price setFont:[UIFont systemFontOfSize:14]];
        [self.lab_price setTextAlignment:NSTextAlignmentRight];
        [self.lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.left.mas_equalTo(SCREEN_WIDTH - 78 - 15);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        self.lab_count = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_count];
        [self.lab_count setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_count setFont:[UIFont systemFontOfSize:14]];
        [self.lab_count setTextAlignment:NSTextAlignmentRight];
        [self.lab_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_price);
            make.left.mas_equalTo(SCREEN_WIDTH - 78 - 15 - 3 - 41);
            make.right.equalTo(self.mas_right).offset(-96);
        }];
        
        self.lab_name = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:14]];
        self.lab_name.numberOfLines = 0;
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_price);
            make.left.mas_equalTo(15);
            make.right.equalTo(self.mas_right).offset(-152);
        }];
        
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(self.lab_name.mas_bottom).offset(8);
        }];
        
    }
    return self;
}

- (void)contentCellWithSupplierCommodityEndity:(SupplierCommodityEndity *)supplierCommodityEndity{
    [self.lab_name setText:supplierCommodityEndity.name];
    [self.lab_count setText:[NSString stringWithFormat:@"x%ld",supplierCommodityEndity.count]];
    [self.lab_price setText:[NSString stringWithFormat:@"¥%.2f",supplierCommodityEndity.price * supplierCommodityEndity.count]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
