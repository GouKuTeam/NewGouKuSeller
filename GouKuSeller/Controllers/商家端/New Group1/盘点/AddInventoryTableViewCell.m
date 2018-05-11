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
        
  
        
        self.lab_inventoryNum = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_inventoryNum];
        [self.lab_inventoryNum setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_inventoryNum setFont:[UIFont systemFontOfSize:14]];
        [self.lab_inventoryNum setTextAlignment:NSTextAlignmentRight];
        [self.lab_inventoryNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 60);
            make.top.mas_equalTo(11.7);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
        }];
        [self.lab_inventoryNum setText:@"123123"];
        
        self.lab_stock = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_stock];
        [self.lab_stock setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_stock setFont:[UIFont systemFontOfSize:14]];
        [self.lab_stock setTextAlignment:NSTextAlignmentRight];
        [self.lab_inventoryNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_inventoryNum.mas_left).offset(-60);
            make.top.mas_equalTo(11.7);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(20);
        }];
        [self.lab_stock setText:@"123123"];
        
        self.lab_name = [[UILabel alloc]init];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:14]];
        self.lab_name.numberOfLines = 0;
        [self.lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(11.7);
            make.right.equalTo(self.lab_stock.mas_left).offset(-10);
            make.height.mas_equalTo(20);
        }];
        [self.lab_name setText:@"手动阀开始的发挥空间士大夫哈萨克东方航空的撒发货快拉上东方航空士大夫哈克斯的返回"];
        [self.lab_stock setText:@"123123"];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
