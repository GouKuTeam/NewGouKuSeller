//
//  SupplierPriceDetailView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/23.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierPriceDetailView.h"

@implementation SupplierPriceDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.5]];
        
        self.v_back = [[UIView alloc]init];
        [self addSubview:self.v_back];
        [self.v_back setBackgroundColor:[UIColor whiteColor]];
        self.v_back.layer.cornerRadius = 12;
        
        self.lab_totalPrice = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_totalPrice];
        [self.lab_totalPrice setText:@"商品总价"];
        [self.lab_totalPrice setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_totalPrice setFont:[UIFont systemFontOfSize:17]];
        [self.lab_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(27);
            make.height.mas_equalTo(24);
        }];
        
        self.lab_yunfei = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_yunfei];
        [self.lab_yunfei setText:@"运费"];
        [self.lab_yunfei setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_yunfei setFont:[UIFont systemFontOfSize:17]];
        [self.lab_yunfei mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(self.lab_totalPrice.mas_bottom).offset(16);
            make.height.mas_equalTo(24);
        }];
        
        self.lab_yuanjia = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_yuanjia];
        [self.lab_yuanjia setText:@"原价"];
        [self.lab_yuanjia setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_yuanjia setFont:[UIFont systemFontOfSize:17]];
        self.lab_yuanjia.clipsToBounds = YES;
        [self.lab_yuanjia mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(self.lab_yunfei.mas_bottom).offset(16);
            make.height.mas_equalTo(24);
        }];
        
        self.lab_changePrice = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_changePrice];
        [self.lab_changePrice setText:@"修改后金额"];
        [self.lab_changePrice setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_changePrice setFont:[UIFont systemFontOfSize:17]];
        [self.lab_changePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(self.lab_yuanjia.mas_bottom).offset(16);
            make.height.mas_equalTo(24);
        }];
        
        
        self.lab_totalPriceDetail = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_totalPriceDetail];
        [self.lab_totalPriceDetail setTextAlignment:NSTextAlignmentRight];
        [self.lab_totalPriceDetail setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_totalPriceDetail setFont:[UIFont systemFontOfSize:17]];
        [self.lab_totalPriceDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_totalPrice.mas_right);
            make.right.equalTo(self.v_back.mas_right).offset(-14);
            make.top.height.equalTo(self.lab_totalPrice);
        }];
        
        self.lab_yunfeiDetail = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_yunfeiDetail];
        [self.lab_yunfeiDetail setTextAlignment:NSTextAlignmentRight];
        [self.lab_yunfeiDetail setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_yunfeiDetail setFont:[UIFont systemFontOfSize:17]];
        [self.lab_yunfeiDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_yunfei.mas_right);
            make.right.equalTo(self.v_back.mas_right).offset(-14);
            make.top.height.equalTo(self.lab_yunfei);
        }];
        
        self.lab_yuanjiaDetail = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_yuanjiaDetail];
        self.lab_yuanjiaDetail.clipsToBounds = YES;
        [self.lab_yuanjiaDetail setTextAlignment:NSTextAlignmentRight];
        [self.lab_yuanjiaDetail setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_yuanjiaDetail setFont:[UIFont systemFontOfSize:17]];
        [self.lab_yuanjiaDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_yuanjia.mas_right);
            make.right.equalTo(self.v_back.mas_right).offset(-14);
            make.top.height.equalTo(self.lab_yuanjia);
        }];
        
        self.lab_changePriceDetail = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_changePriceDetail];
        [self.lab_changePriceDetail setTextAlignment:NSTextAlignmentRight];
        [self.lab_changePriceDetail setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_changePriceDetail setFont:[UIFont systemFontOfSize:17]];
        [self.lab_changePriceDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_changePrice.mas_right);
            make.right.equalTo(self.v_back.mas_right).offset(-14);
            make.top.height.equalTo(self.lab_changePrice);
        }];
        
        self.img_line = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_line];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_changePrice.mas_bottom).offset(23.5);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(0.5);
        }];
        
        self.btn_sure = [[UIButton alloc]init];
        [self.v_back addSubview:self.btn_sure];
        [self.btn_sure setTitle:@"我知道了" forState:UIControlStateNormal];
        [self.btn_sure setTitleColor:[UIColor colorWithHexString:@"#2281D2"] forState:UIControlStateNormal];
        self.btn_sure.titleLabel.font = [UIFont systemFontOfSize:17];
        [self.btn_sure addTarget:self action:@selector(hideAction) forControlEvents:UIControlEventTouchUpInside];
        [self.btn_sure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.img_line.mas_bottom);
            make.width.equalTo(self.v_back);
            make.height.mas_equalTo(44);
        }];
        
        [self.v_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(270);
            make.bottom.equalTo(self.btn_sure.mas_bottom);
        }];
        
    }
    return self;
}

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity{
    self.lab_totalPriceDetail.text = [NSString stringWithFormat:@"%.2f",purchaseOrderEntity.payTotal - purchaseOrderEntity.payFreight];
    self.lab_yunfeiDetail.text = [NSString stringWithFormat:@"%.2f",purchaseOrderEntity.payFreight];
    if (purchaseOrderEntity.payActual != purchaseOrderEntity.payTotal) {
        self.lab_yuanjiaDetail.text = [NSString stringWithFormat:@"%.2f",purchaseOrderEntity.payTotal];
        self.lab_changePriceDetail.text = [NSString stringWithFormat:@"%.2f",purchaseOrderEntity.payActual];
        [self.lab_changePrice setText:@"修改后金额"];
        [self.lab_yuanjia mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_yunfei.mas_bottom).offset(16);
            make.height.mas_equalTo(24);
        }];
        [self.lab_yuanjiaDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self.lab_yuanjia);
        }];
        
    }else{
        [self.lab_changePrice setText:@"合计"];
        [self.lab_yuanjia mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lab_yunfei.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        [self.lab_yuanjiaDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self.lab_yuanjia);
        }];
        [self.lab_changePriceDetail setText:[NSString stringWithFormat:@"%.2f",purchaseOrderEntity.payTotal]];
    }
}

- (void)hideAction{
    [self setHidden:YES];
}

@end
