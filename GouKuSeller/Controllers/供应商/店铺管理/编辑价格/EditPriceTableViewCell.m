//
//  EditPriceTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EditPriceTableViewCell.h"

@implementation EditPriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_name = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 70, 44)];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name setText:@"单位名称"];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_dengyu = [[UILabel alloc]initWithFrame:CGRectMake(15, 44, 70, 44)];
        [self.contentView addSubview:self.lab_dengyu];
        [self.lab_dengyu setText:@"等于"];
        [self.lab_dengyu setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_dengyu setFont:[UIFont systemFontOfSize:16]];
        
        self.lab_price = [[UILabel alloc]initWithFrame:CGRectMake(15, 88, 70, 44)];
        [self.contentView addSubview:self.lab_price];
        [self.lab_price setText:@"价格"];
        [self.lab_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_price setFont:[UIFont systemFontOfSize:16]];
        
        UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15, 0.5)];
        [self.contentView addSubview:img1];
        [img1 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44 * 2, SCREEN_WIDTH - 15, 0.5)];
        [self.contentView addSubview:img2];
        [img2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        UIImageView *img3 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 44 * 3, SCREEN_WIDTH - 15, 0.5)];
        [self.contentView addSubview:img3];
        [img3 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        
        self.tf_name = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 213, 0, 200, 45)];
        [self.contentView addSubview:self.tf_name];
        [self.tf_name setPlaceholder:@"输入名称"];
        [self.tf_name setFont:[UIFont systemFontOfSize:16]];
        [self.tf_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.tf_name setTextAlignment:NSTextAlignmentRight];
        
        self.lab_jian = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 13, 44, 30, 44)];
        [self.contentView addSubview:self.lab_jian];
        [self.lab_jian setText:@"件"];
        [self.lab_jian setFont:[UIFont systemFontOfSize:16]];
        [self.lab_jian setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_jian setTextAlignment:NSTextAlignmentRight];

        
        self.tf_dengyu = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 140, 44, 100, 45)];
        [self.contentView addSubview:self.tf_dengyu];
        [self.tf_dengyu setPlaceholder:@"输入数量"];
        [self.tf_dengyu setFont:[UIFont systemFontOfSize:16]];
        [self.tf_dengyu setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.tf_dengyu setTextAlignment:NSTextAlignmentRight];
        
        self.tf_price = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 113, 88, 100, 45)];
        [self.contentView addSubview:self.tf_price];
        [self.tf_price setPlaceholder:@"输入价格"];
        [self.tf_price setFont:[UIFont systemFontOfSize:16]];
        [self.tf_price setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.tf_price setTextAlignment:NSTextAlignmentRight];
        
        self.btn_delete = [[UIButton alloc]initWithFrame:CGRectMake(0, 132, SCREEN_WIDTH, 42)];
        [self.contentView addSubview:self.btn_delete];
        [self.btn_delete setTitle:@"删除出售单位" forState:UIControlStateNormal];
        self.btn_delete.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.btn_delete setTitleColor:[UIColor colorWithHexString:@"#DC2E2E"] forState:UIControlStateNormal];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
