//
//  StoreCategoryTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/9.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "StoreCategoryTableViewCell.h"

@implementation StoreCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_categoryName = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width - 30, 55)];
        [self.contentView addSubview:self.lab_categoryName];
        self.lab_categoryName.font = [UIFont systemFontOfSize:14];
        [self.lab_categoryName setTextColor:[UIColor colorWithHexString:@"#616161"]];
        
        self.img_shu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 4, 55)];
        [self.contentView addSubview:self.img_shu];
        [self.img_shu setBackgroundColor:[UIColor colorWithHexString:@"#4167b2"]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
