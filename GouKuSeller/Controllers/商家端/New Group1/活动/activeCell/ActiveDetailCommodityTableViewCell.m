//
//  ActiveDetailCommodityTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveDetailCommodityTableViewCell.h"

@implementation ActiveDetailCommodityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.lab_name = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, SCREEN_WIDTH - 30, 20)];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_name setFont:[UIFont boldSystemFontOfSize:14]];
        
        self.lab_price = [[UILabel alloc]initWithFrame:CGRectMake(15, 34, 90, 20)];
        [self.contentView addSubview:self.lab_price];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_price setFont:[UIFont systemFontOfSize:14]];
        
        self.lab_active = [[UILabel alloc]initWithFrame:CGRectMake(161.5, 34, SCREEN_WIDTH - 180, 20)];
        [self.contentView addSubview:self.lab_active];
        [self.lab_active setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_active setFont:[UIFont systemFontOfSize:14]];
        
    }
    return self;
}

-(void)contentCellWithActiveEntity:(ActiveRulesEntity *)entity{
    if (entity.wareName) {
        [self.lab_name setText:entity.wareName];
    }
    [self.lab_price setText:[NSString stringWithFormat:@"原价¥%.2f",entity.wareOprice]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
