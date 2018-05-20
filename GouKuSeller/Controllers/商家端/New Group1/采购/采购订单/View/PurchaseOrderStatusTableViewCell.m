//
//  PurchaseOrderStatusTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseOrderStatusTableViewCell.h"

@implementation PurchaseOrderStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.img_top = [[UIImageView alloc]initWithFrame:CGRectMake(25, 0, 1, 25)];
        [self.contentView addSubview:self.img_top];
        [self.img_top setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        self.img_up = [[UIImageView alloc]initWithFrame:CGRectMake(25, 25, 1, 25)];
        [self.contentView addSubview:self.img_up];
        [self.img_up setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        self.img_center = [[UIImageView alloc]initWithFrame:CGRectMake(21, 21, 8, 8)];
        [self.contentView addSubview:self.img_center];
        [self.img_center setImage:[UIImage imageNamed:@"grey_dot"]];
        
        self.lab_title = [[UILabel alloc]initWithFrame:CGRectMake(42, 0, 100, 50)];
        [self.contentView addSubview:self.lab_title];
        [self.lab_title setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_title setFont:[UIFont systemFontOfSize:14]];
        
        self.lab_time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150 - 14,0,150, 50)];
        [self.contentView addSubview:self.lab_time];
        [self.lab_time setTextColor:[UIColor colorWithHexString:@"#979797"]];
        [self.lab_time setFont:[UIFont systemFontOfSize:14]];
        [self.lab_time setTextAlignment:NSTextAlignmentRight];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
