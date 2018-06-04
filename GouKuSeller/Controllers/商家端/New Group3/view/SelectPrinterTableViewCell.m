//
//  SelectPrinterTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SelectPrinterTableViewCell.h"

@implementation SelectPrinterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.lab_printerName = [[UILabel alloc]initWithFrame:CGRectMake(15, 11, SCREEN_WIDTH - 15 - 54 - 13 - 15, 22)];
        [self.contentView addSubview:self.lab_printerName];
        [self.lab_printerName setTextColor:[UIColor blackColor]];
        [self.lab_printerName setFont:[UIFont systemFontOfSize:16]];
        
        self.btn_connectPrinter = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 54 - 13, 6, 54, 32)];
        [self.contentView addSubview:self.btn_connectPrinter];
        [self.btn_connectPrinter setTitle:@"连接" forState:UIControlStateNormal];
        [self.btn_connectPrinter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn_connectPrinter setBackgroundColor:[UIColor colorWithHexString:@"#4A90E2"]];
        self.btn_connectPrinter.layer.cornerRadius = 2.0f;
        self.btn_connectPrinter.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
