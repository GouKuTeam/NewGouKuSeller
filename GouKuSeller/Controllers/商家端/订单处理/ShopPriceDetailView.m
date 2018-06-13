//
//  ShopPriceDetailView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopPriceDetailView.h"

@implementation ShopPriceDetailView

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
        
        
        self.lab_youhui = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_youhui];
        [self.lab_youhui setText:@"优惠"];
        [self.lab_youhui setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_youhui setFont:[UIFont systemFontOfSize:17]];
        self.lab_youhui.clipsToBounds = YES;
        [self.lab_youhui mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(self.lab_totalPrice.mas_bottom).offset(16);
            make.height.mas_equalTo(24);
        }];
        
        self.lab_shouru = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_shouru];
        [self.lab_shouru setText:@"本单收入"];
        [self.lab_shouru setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_shouru setFont:[UIFont systemFontOfSize:17]];
        [self.lab_shouru mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(self.lab_youhui.mas_bottom).offset(16);
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
        
        self.lab_youhuiDetail = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_youhuiDetail];
        [self.lab_youhuiDetail setTextAlignment:NSTextAlignmentRight];
        [self.lab_youhuiDetail setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_youhuiDetail setFont:[UIFont systemFontOfSize:17]];
        [self.lab_youhuiDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_youhui.mas_right);
            make.right.equalTo(self.v_back.mas_right).offset(-14);
            make.top.height.equalTo(self.lab_youhui);
        }];
        
        self.lab_shouruDetail = [[UILabel alloc]init];
        [self.v_back addSubview:self.lab_shouruDetail];
        self.lab_shouruDetail.clipsToBounds = YES;
        [self.lab_shouruDetail setTextAlignment:NSTextAlignmentRight];
        [self.lab_shouruDetail setTextColor:[UIColor colorWithHexString:@"#030303"]];
        [self.lab_shouruDetail setFont:[UIFont systemFontOfSize:17]];
        [self.lab_shouruDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_shouru.mas_right);
            make.right.equalTo(self.v_back.mas_right).offset(-14);
            make.top.height.equalTo(self.lab_shouru);
        }];
        
        self.img_line = [[UIImageView alloc]init];
        [self.v_back addSubview:self.img_line];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_shouru.mas_bottom).offset(23.5);
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
    self.lab_totalPriceDetail.text = [NSString stringWithFormat:@"¥%.2f",purchaseOrderEntity.payWareTotal];
    self.lab_shouruDetail.text = [NSString stringWithFormat:@"¥%.2f",purchaseOrderEntity.payActual];
    if (purchaseOrderEntity.payReduce < 0) {

        self.lab_youhuiDetail.text = [NSString stringWithFormat:@"¥%.2f",purchaseOrderEntity.payReduce];
        [self.lab_youhui setHidden:NO];
        [self.lab_youhuiDetail setHidden:NO];
        [self.lab_shouru mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(self.lab_youhui.mas_bottom).offset(16);
            make.height.mas_equalTo(24);
        }];
        [self.lab_shouruDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_shouru.mas_right);
            make.right.equalTo(self.v_back.mas_right).offset(-14);
            make.top.height.equalTo(self.lab_shouru);
        }];
        
    }else{
        [self.lab_youhui setHidden:YES];
        [self.lab_youhuiDetail setHidden:YES];
        [self.lab_shouru mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.equalTo(self.lab_totalPrice.mas_bottom).offset(16);
            make.height.mas_equalTo(24);
        }];
        [self.lab_shouruDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_youhui.mas_right);
            make.right.equalTo(self.v_back.mas_right).offset(-14);
            make.top.height.equalTo(self.lab_youhui);
        }];
    }
}

- (void)hideAction{
    [self setHidden:YES];
}

@end
