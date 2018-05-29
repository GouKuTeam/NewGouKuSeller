//
//  InventoryDetailTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryDetailTableViewCell.h"

@implementation InventoryDetailTableViewCell

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
        [self.lab_name setFont:[UIFont systemFontOfSize:14]];
        self.lab_name.numberOfLines = 0;
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(11.7);
            make.right.equalTo(self.mas_right).offset(-130);
        }];
        
        
        self.lab_stock = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_stock];
        [self.lab_stock setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_stock setFont:[UIFont systemFontOfSize:14]];
        [self.lab_stock setTextAlignment:NSTextAlignmentRight];
        [self.lab_stock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 140);
            make.top.mas_equalTo(11.7);
            make.right.equalTo(self.mas_right).offset(-80);
        }];
        
        self.lab_inventoryNum = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_inventoryNum];
        [self.lab_inventoryNum setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_inventoryNum setFont:[UIFont systemFontOfSize:14]];
        [self.lab_inventoryNum setTextAlignment:NSTextAlignmentRight];
        [self.lab_inventoryNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 70);
            make.top.mas_equalTo(11.7);
            make.width.mas_equalTo(60);
        }];
        
        self.lab_chaNum = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_chaNum];
        [self.lab_chaNum setFont:[UIFont systemFontOfSize:12]];
        [self.lab_chaNum setTextAlignment:NSTextAlignmentRight];
        [self.lab_chaNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_name.mas_bottom);
            make.left.mas_equalTo(SCREEN_WIDTH - 70);
            make.width.mas_equalTo(60);
        }];
        
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(self.lab_chaNum.mas_bottom).offset(9.3);
        }];
        
    }
    return self;
}

- (void)contentCellWithInventoryEntity:(InventoryEntity *)entity{
    [self.lab_name setText:entity.name];
    [self.lab_stock setText:[NSString stringWithFormat:@"%d",entity.stock]];
    [self.lab_inventoryNum setText:[NSString stringWithFormat:@"%d",entity.inventoryNum]];
    if (entity.stock > entity.inventoryNum) {
        [self.lab_chaNum setText:[NSString stringWithFormat:@"亏%d",entity.stock - entity.inventoryNum]];
        [self.lab_chaNum setTextColor:[UIColor colorWithHexString:@"#D0021B"]];
    }
    if (entity.stock < entity.inventoryNum) {
        [self.lab_chaNum setText:[NSString stringWithFormat:@"盈%d",entity.inventoryNum - entity.stock]];
        [self.lab_chaNum setTextColor:[UIColor colorWithHexString:@"#329702"]];
    }
    if (entity.stock == entity.inventoryNum) {
        [self.lab_chaNum setText:@""];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
