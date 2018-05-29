//
//  AddInventoryTabHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddInventoryTabHeaderView.h"

@implementation AddInventoryTabHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.lab_name = [[UILabel alloc]initWithFrame:CGRectMake(15, 13, 60, 18)];
        [self addSubview:self.lab_name];
        [self.lab_name setText:@"商品名称"];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:13]];
        
        self.lab_stock = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 13, 30, 18)];
        [self addSubview:self.lab_stock];
        [self.lab_stock setText:@"库存"];
        [self.lab_stock setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_stock setFont:[UIFont systemFontOfSize:13]];
        
        
        self.lab_inventoryNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 13, 40, 18)];
        [self addSubview:self.lab_inventoryNum];
        [self.lab_inventoryNum setText:@"盘点数"];
        [self.lab_inventoryNum setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_inventoryNum setFont:[UIFont systemFontOfSize:13]];
        
        UIImageView *img_line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 0.5)];
        [self addSubview:img_line];
        [img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
    }
    return self;
}

@end
