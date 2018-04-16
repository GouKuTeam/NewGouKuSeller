
//
//  CashierTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/29.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CashierTableViewCell.h"

@implementation CashierTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_name = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_num = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_num];
        [self.lab_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_name.mas_right).offset(5);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(22);
            make.right.lessThanOrEqualTo(self.mas_right).offset(-89);
        }];
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(22);
        }];
        [self.lab_num setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_num setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_price_yingfu = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_price_yingfu];
        [self.lab_price_yingfu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 90);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(22);
            make.right.equalTo(self.mas_right).offset(-9);
        }];
        [self.lab_price_yingfu setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_price_yingfu setFont:[UIFont systemFontOfSize:16]];
        self.lab_price_yingfu.textAlignment = NSTextAlignmentRight;
        
        self.lab_price_yuanjia = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_price_yuanjia];
        [self.lab_price_yuanjia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 90);
            make.top.equalTo(self.lab_price_yingfu.mas_bottom).offset(2);
            make.height.mas_equalTo(22);
            make.right.equalTo(self.mas_right).offset(-9);
        }];
        [self.lab_price_yuanjia setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_price_yuanjia setFont:[UIFont systemFontOfSize:13]];
        self.lab_price_yuanjia.textAlignment = NSTextAlignmentRight;
        
    }
    return self;
}

-(void)contentWithCashierCommodity:(CashierCommodityEntity *)entity{
    [self.lab_name setText:entity.name];
    [self.lab_price_yingfu setText:[NSString stringWithFormat:@"¥%.2f",entity.settlementPrice * entity.amount]];
    if (entity.amount > 1) {
        [self.lab_num setText:[NSString stringWithFormat:@"x%d",entity.amount]];
    }else{
        [self.lab_num setText:@""];
    }
    if (entity.price > entity.settlementPrice) {
        //有活动的情况
        [self.lab_price_yuanjia setHidden:NO];
        [self.lab_price_yuanjia setText:[NSString stringWithFormat:@"¥%.2f",entity.price * entity.amount]];
        NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.lab_price_yuanjia.text]];
        [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
        self.lab_price_yuanjia.attributedText = newPrice;
    }else{
        [self.lab_price_yuanjia setHidden:YES];
    }
}

-(void)contentWithItemEntity:(ItemsEntity *)entity{
    [self.lab_name setText:entity.name];
    [self.lab_price_yingfu setText:[NSString stringWithFormat:@"¥%.2f",(entity.price - entity.pricePreferential) * entity.amount]];
    if (entity.amount > 1) {
        [self.lab_num setText:[NSString stringWithFormat:@"x%d",entity.amount]];
    }else{
        [self.lab_num setText:@""];
    }
    if (entity.pricePreferential > 0) {
        //有活动的情况
        [self.lab_price_yuanjia setHidden:NO];
        [self.lab_price_yuanjia setText:[NSString stringWithFormat:@"¥%.2f",entity.price * entity.amount]];
        NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.lab_price_yuanjia.text]];
        [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
        self.lab_price_yuanjia.attributedText = newPrice;
    }else{
        [self.lab_price_yuanjia setHidden:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
