//
//  AddInventoryTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddInventoryTableViewCell.h"

@implementation AddInventoryTableViewCell

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
        
//        self.img_line = [[UIImageView alloc]init];
//        [self.contentView addSubview:self.img_line];
//        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
//        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.top.equalTo(self.lab_name.mas_bottom).offset(11.2);
//            make.width.mas_equalTo(SCREEN_WIDTH - 10);
//            make.height.mas_equalTo(0.5);
//        }];
        
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(self.lab_name.mas_bottom).offset(11.7);
        }];
        
    }
    return self;
}

- (void)contentCellWithInventoryEntity:(InventoryEntity *)entity{
    [self.lab_name setText:entity.name];
    [self.lab_stock setText:[NSString stringWithFormat:@"%d",entity.stock]];
    if (entity.inventoryNum >= 0) {
       [self.lab_inventoryNum setText:[NSString stringWithFormat:@"%d",entity.inventoryNum]];
    }else{
        [self.lab_inventoryNum setText:@""];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
