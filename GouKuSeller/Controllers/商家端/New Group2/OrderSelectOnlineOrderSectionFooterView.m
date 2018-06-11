//
//  OrderSelectOnlineOrderSectionFooterView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderSelectOnlineOrderSectionFooterView.h"
#import "DateUtils.h"

@implementation OrderSelectOnlineOrderSectionFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor whiteColor];
        self.img_line = [[UIImageView alloc]init];
        [self addSubview:self.img_line];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        
        self.btn_priceDetail = [[UIButton alloc]init];
        [self addSubview:self.btn_priceDetail];
        [self.btn_priceDetail setBackgroundImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
        [self.btn_priceDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 14 - 20);
            make.top.equalTo(self.img_line.mas_bottom).offset(9);
            make.width.height.mas_equalTo(20);
        }];
        
        self.lab_countAndPrice = [[UILabel alloc]init];
        [self addSubview:self.lab_countAndPrice];
        [self.lab_countAndPrice setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_countAndPrice setTextAlignment:NSTextAlignmentRight];
        [self.lab_countAndPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.equalTo(self.mas_right).offset(-39);
            make.height.mas_equalTo(20);
            make.top.equalTo(self.btn_priceDetail);
        }];
        
        self.img_line2 = [[UIImageView alloc]init];
        [self addSubview:self.img_line2];
        [self.img_line2 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self.img_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(8);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        self.lab_createTime = [[UILabel alloc]init];
        [self addSubview:self.lab_createTime];
        [self.lab_createTime setFont:[UIFont systemFontOfSize:12]];
        [self.lab_createTime setTextColor:[UIColor colorWithHexString:@"#959595"]];
        [self.lab_createTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_line);
            make.top.equalTo(self.img_line2.mas_bottom).offset(10);
            make.height.mas_equalTo(17);
        }];
        
        self.lab_orderNum = [[UILabel alloc]init];
        [self addSubview:self.lab_orderNum];
        [self.lab_orderNum setFont:[UIFont systemFontOfSize:12]];
        [self.lab_orderNum setTextColor:[UIColor colorWithHexString:@"#959595"]];
        [self.lab_orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.equalTo(self.lab_createTime);
            make.top.equalTo(self.lab_createTime.mas_bottom).offset(3);
        }];
        
        self.btn_copy = [[UIButton alloc]init];
        [self addSubview:self.btn_copy];
        [self.btn_copy setTitle:@"复制" forState:UIControlStateNormal];
        [self.btn_copy setTitleColor:[UIColor colorWithHexString:@"#4167B2"] forState:UIControlStateNormal];
        self.btn_copy.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btn_copy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_orderNum.mas_right).offset(2);
            make.width.mas_equalTo(25);
            make.top.equalTo(self.lab_orderNum);
            make.height.mas_equalTo(17);
        }];
        
        self.btn_printer = [[UIButton alloc]init];
        [self addSubview:self.btn_printer];
        [self.btn_printer setTitle:@"打印" forState:UIControlStateNormal];
        [self.btn_printer setTitleColor:[UIColor colorWithHexString:@"#ABABAB"] forState:UIControlStateNormal];
        self.btn_printer.titleLabel.font = [UIFont systemFontOfSize:14];
        self.btn_printer.layer.cornerRadius = 1.5;
        self.btn_printer.layer.borderWidth = 0.5;
        self.btn_printer.layer.borderColor = [[UIColor colorWithHexString:@"#ABABAB"] CGColor];
        [self.btn_printer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 15 - 40);
            make.width.mas_equalTo(40);
            make.top.equalTo(self.lab_createTime.mas_bottom).offset(-5);
            make.height.mas_equalTo(25);
        }];
        
    }
    return self;
}

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity{
    NSString *str_countAndPrice = [NSString stringWithFormat:@"共%d件，合计¥%.2f",[purchaseOrderEntity.count intValue],purchaseOrderEntity.payActual];
    NSString *str_count = [NSString stringWithFormat:@"共%d件，合计",[purchaseOrderEntity.count intValue]];
    NSMutableAttributedString *str_amount = [[NSMutableAttributedString alloc]initWithString:str_countAndPrice];
    [str_amount addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str_count.length)];
    [self.lab_countAndPrice setAttributedText:str_amount];
    
    [self.lab_createTime setText:[NSString stringWithFormat:@"%@下单",[DateUtils stringFromTimeInterval:purchaseOrderEntity.createTime formatter:@"MM-dd HH:mm"]]];
    [self.lab_orderNum setText:[NSString stringWithFormat:@"订单编号:%@",purchaseOrderEntity.orderId]];
    self.purchaseOrderEntity = purchaseOrderEntity;
}

@end
