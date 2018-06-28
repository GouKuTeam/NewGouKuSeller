//
//  EleMeBillHeaderView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/26.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "EleMeBillHeaderView.h"

@implementation EleMeBillHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.v_titleBack = [[UIView alloc]init];
        [self addSubview:self.v_titleBack];
        [self.v_titleBack setBackgroundColor:[UIColor whiteColor]];
        [self.v_titleBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(203);
        }];
        
        self.lab_title = [[UILabel alloc]init];
        [self.v_titleBack addSubview:self.lab_title];
        [self.lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(11);
            make.height.mas_equalTo(22);
        }];
        [self.lab_title setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_title setFont:[UIFont boldSystemFontOfSize:16]];
        
        self.lab_status = [[UILabel alloc]init];
        [self.v_titleBack addSubview:self.lab_status];
        [self.lab_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 60 - 15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.mas_equalTo(11);
            make.height.mas_equalTo(22);
        }];
        [self.lab_status setTextColor:[UIColor colorWithHexString:@"#F5A623"]];
        [self.lab_status setFont:[UIFont boldSystemFontOfSize:16]];
        [self.lab_status setTextAlignment:NSTextAlignmentRight];
        
        self.img_line1 = [[UIImageView alloc]init];
        [self.v_titleBack addSubview:self.img_line1];
        [self.img_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_title.mas_bottom).offset(12);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line1 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
        
        self.lab_billT = [[UILabel alloc]init];
        [self.v_titleBack addSubview:self.lab_billT];
        [self.lab_billT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_line1.mas_bottom).offset(16);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(17);
        }];
        [self.lab_billT setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_billT setFont:[UIFont systemFontOfSize:12]];
        [self.lab_billT setTextAlignment:NSTextAlignmentCenter];
        [self.lab_billT setText:@"账单金额  (元)"];
        
        self.lab_billPrice = [[UILabel alloc]init];
        [self.v_titleBack addSubview:self.lab_billPrice];
        [self.lab_billPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_billT.mas_bottom).offset(9);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(28);
        }];
        [self.lab_billPrice setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_billPrice setFont:[UIFont boldSystemFontOfSize:20]];
        [self.lab_billPrice setTextAlignment:NSTextAlignmentCenter];
        
        self.img_line2 = [[UIImageView alloc]init];
        [self.v_titleBack addSubview:self.img_line2];
        [self.img_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_billPrice.mas_bottom).offset(8);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line2 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
        
        self.lab_completePriceT = [[UILabel alloc]init];
        [self.v_titleBack addSubview:self.lab_completePriceT];
        [self.lab_completePriceT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.img_line2.mas_bottom).offset(13);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(17);
        }];
        [self.lab_completePriceT setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_completePriceT setFont:[UIFont systemFontOfSize:12]];
        [self.lab_completePriceT setTextAlignment:NSTextAlignmentCenter];
        [self.lab_completePriceT setText:@"完成单金额（元）"];
        
        self.lab_completePrice = [[UILabel alloc]init];
        [self.v_titleBack addSubview:self.lab_completePrice];
        [self.lab_completePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_completePriceT.mas_bottom).offset(9);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(28);
        }];
        [self.lab_completePrice setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_completePrice setFont:[UIFont boldSystemFontOfSize:20]];
        [self.lab_completePrice setTextAlignment:NSTextAlignmentCenter];
        
        self.lab_refundPriceT = [[UILabel alloc]init];
        [self.v_titleBack addSubview:self.lab_refundPriceT];
        [self.lab_refundPriceT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH / 2);
            make.top.equalTo(self.img_line2.mas_bottom).offset(13);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(17);
        }];
        [self.lab_refundPriceT setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_refundPriceT setFont:[UIFont systemFontOfSize:12]];
        [self.lab_refundPriceT setTextAlignment:NSTextAlignmentCenter];
        [self.lab_refundPriceT setText:@"退款金额 （元）"];
        
        self.lab_refundPrice = [[UILabel alloc]init];
        [self.v_titleBack addSubview:self.lab_refundPrice];
        [self.lab_refundPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH / 2);
            make.top.equalTo(self.lab_refundPriceT.mas_bottom).offset(9);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
            make.height.mas_equalTo(28);
        }];
        [self.lab_refundPrice setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_refundPrice setFont:[UIFont boldSystemFontOfSize:20]];
        [self.lab_refundPrice setTextAlignment:NSTextAlignmentCenter];
        
        self.v_midBack = [[UIView alloc]init];
        [self addSubview:self.v_midBack];
        [self.v_midBack setBackgroundColor:[UIColor whiteColor]];
        [self.v_midBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.v_titleBack.mas_bottom).offset(18);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(44);
        }];
        
        self.lab_xuhao = [[UILabel alloc]init];
        [self.v_midBack addSubview:self.lab_xuhao];
        [self.lab_xuhao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(14);
            make.width.mas_equalTo((SCREEN_WIDTH -30) / 3);
            make.height.mas_equalTo(17);
        }];
        [self.lab_xuhao setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_xuhao setFont:[UIFont systemFontOfSize:12]];
        [self.lab_xuhao setTextAlignment:NSTextAlignmentLeft];
        [self.lab_xuhao setText:@"序号"];
        
        self.lab_orderStatus = [[UILabel alloc]init];
        [self.v_midBack addSubview:self.lab_orderStatus];
        [self.lab_orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15 + (SCREEN_WIDTH -30) / 3);
            make.top.mas_equalTo(14);
            make.width.mas_equalTo((SCREEN_WIDTH -30) / 3);
            make.height.mas_equalTo(17);
        }];
        [self.lab_orderStatus setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_orderStatus setFont:[UIFont systemFontOfSize:12]];
        [self.lab_orderStatus setTextAlignment:NSTextAlignmentCenter];
        [self.lab_orderStatus setText:@"订单状态"];
        
        self.lab_jiesuanPrice = [[UILabel alloc]init];
        [self.v_midBack addSubview:self.lab_jiesuanPrice];
        [self.lab_jiesuanPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - (15 + (SCREEN_WIDTH -30) / 3));
            make.top.mas_equalTo(14);
            make.width.mas_equalTo((SCREEN_WIDTH -30) / 3);
            make.height.mas_equalTo(17);
        }];
        [self.lab_jiesuanPrice setTextColor:[UIColor colorWithHexString:@"#4A4A4A"]];
        [self.lab_jiesuanPrice setFont:[UIFont systemFontOfSize:12]];
        [self.lab_jiesuanPrice setTextAlignment:NSTextAlignmentRight];
        [self.lab_jiesuanPrice setText:@"结算金额 (元)"];
        
        self.img_line3 = [[UIImageView alloc]init];
        [self.v_midBack addSubview:self.img_line3];
        [self.img_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(43.5);
            make.width.mas_equalTo(SCREEN_WIDTH - 15);
            make.height.mas_equalTo(0.5);
        }];
        [self.img_line3 setBackgroundColor:[UIColor colorWithHexString:@"#CFCFCF"]];
        
    }
    
    return self;
}

-(void)contentEleMeBillHeaderViewWithDic:(NSDictionary *)dic{
    [self.lab_title setText:[NSString stringWithFormat:@"%@ 完成 %@ 单",[dic objectForKey:@"date"],[dic objectForKey:@"orderNum"]]];
    if ([[dic objectForKey:@"billStatus"] intValue] == 0) {
        [self.lab_status setText:@"待对账"];
        [self.lab_status setTextColor:[UIColor colorWithHexString:@"#F5A623"]];
    }else{
        [self.lab_status setText:@"对账成功"];
        [self.lab_status setTextColor:[UIColor colorWithHexString:@"#329702"]];
    }
    [self.lab_billPrice setText:[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"billMoney"] doubleValue]]];
    [self.lab_completePrice setText:[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"orderMoney"] doubleValue]]];
    [self.lab_refundPrice setText:[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"drawbackMoney"] doubleValue]]];
    
}
@end
