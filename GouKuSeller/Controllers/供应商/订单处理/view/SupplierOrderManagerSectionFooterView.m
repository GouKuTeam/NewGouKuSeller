//
//  SupplierOrderManagerSectionFooterView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierOrderManagerSectionFooterView.h"
#import "DateUtils.h"
#import "CountDownManager.h"

@implementation SupplierOrderManagerSectionFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(countDownNotfifcation) name:kCountDownNotification object:nil];
        self.backgroundColor = [UIColor whiteColor];
        self.img_line = [[UIImageView alloc]init];
        [self addSubview:self.img_line];
        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self.img_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
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
        [self.lab_createTimeAndNum setFont:[UIFont boldSystemFontOfSize:16]];
        [self addSubview:self.lab_countAndPrice];
        [self.lab_countAndPrice setTextAlignment:NSTextAlignmentRight];
        [self.lab_countAndPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.equalTo(self.mas_right).offset(-39);
            make.height.mas_equalTo(20);
            make.top.equalTo(self.btn_priceDetail);
        }];
        
        self.btn_cancelOrder = [[UIButton alloc]init];
        [self addSubview:self.btn_cancelOrder];
        [self.btn_cancelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.btn_cancelOrder setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_cancelOrder.titleLabel.font = [UIFont systemFontOfSize:16];
        self.btn_cancelOrder.layer.borderWidth = 1.0f;
        self.btn_cancelOrder.layer.borderColor = [[UIColor colorWithHexString:@"#ABABAB"] CGColor];
        self.btn_cancelOrder.layer.cornerRadius = 3.0f;
        [self.btn_cancelOrder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(12);
            make.width.mas_equalTo(92);
            make.height.mas_equalTo(38);
        }];
        
        self.btn_right = [[UIButton alloc]init];
        [self addSubview:self.btn_right];
        [self.btn_right setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [self.btn_right setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
        self.btn_right.titleLabel.font = [UIFont systemFontOfSize:16];
        self.btn_right.layer.cornerRadius = 3.0f;
        [self.btn_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btn_cancelOrder.mas_right).offset(10.4);
            make.top.height.equalTo(self.btn_cancelOrder);
            make.right.equalTo(self.mas_right).offset(-15.1);
        }];
        
        self.v_order = [[UIView alloc]init];
        [self addSubview:self.v_order];
        [self.v_order setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        [self.v_order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.btn_cancelOrder.mas_bottom).offset(15);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(28);
        }];
        
        self.btn_copy = [[UIButton alloc]init];
        [self.v_order addSubview:self.btn_copy];
        [self.btn_copy setTitle:@"复制" forState:UIControlStateNormal];
        [self.btn_copy setTitleColor:[UIColor colorWithHexString:@"#4167B2"] forState:UIControlStateNormal];
        self.btn_copy.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btn_copy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 15 - 25);
            make.width.mas_equalTo(25);
            make.top.mas_equalTo(8);
            make.height.mas_equalTo(17);
        }];
        
        self.lab_createTimeAndNum = [[UILabel alloc]init];
        [self.v_order addSubview:self.lab_createTimeAndNum];
        [self.lab_createTimeAndNum setTextColor:[UIColor colorWithHexString:@"#959595"]];
        [self.lab_createTimeAndNum setFont:[UIFont systemFontOfSize:12]];
        [self.lab_createTimeAndNum setTextAlignment:NSTextAlignmentRight];
        [self.lab_createTimeAndNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.equalTo(self.mas_right).offset(-47);
            make.top.mas_equalTo(8);
            make.height.mas_equalTo(17);
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
    [self.lab_createTimeAndNum setText:[NSString stringWithFormat:@"%@下单    订单编号：%@",[DateUtils stringFromTimeInterval:purchaseOrderEntity.createTime formatter:@"MM-dd HH:mm"],purchaseOrderEntity.orderId]];
    if (purchaseOrderEntity.status == 0) {
        [self.btn_cancelOrder mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(12);
            make.width.mas_equalTo(92);
            make.height.mas_equalTo(38);
        }];
        [self.btn_right setTitle:[NSString stringWithFormat:@"修改价格%02zd:%02zd:%02zd",purchaseOrderEntity.countDown/3600,(purchaseOrderEntity.countDown/60)%60,purchaseOrderEntity.countDown%60] forState:UIControlStateNormal];
    }else if(purchaseOrderEntity.status == 2){
        [self.btn_right setTitle:@"发货" forState:UIControlStateNormal];
        [self.btn_cancelOrder mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(12);
            make.width.mas_equalTo(92);
            make.height.mas_equalTo(38);
        }];
    }else if (purchaseOrderEntity.status == 3){
        [self.btn_right setHidden:YES];
        [self.btn_cancelOrder setHidden:NO];
        [self.btn_cancelOrder mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 92 - 15);
            make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(12);
            make.width.mas_equalTo(92);
            make.height.mas_equalTo(38);
        }];
    }else if (purchaseOrderEntity.status == 8 || purchaseOrderEntity.status == 9){
        [self.btn_cancelOrder setHidden:YES];
        [self.btn_right setHidden:YES];
        [self.v_order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(12);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(28);
        }];
    }
    self.purchaseOrderEntity = purchaseOrderEntity;
}

- (void)countDownNotfifcation{
    if (self.purchaseOrderEntity.status == 0) {
        NSInteger countDown = self.purchaseOrderEntity.countDown - 1;
        self.purchaseOrderEntity.countDown = self.purchaseOrderEntity.countDown - 1;
        if (countDown < 0) {
        }else{
            [self.btn_right setTitle:[NSString stringWithFormat:@"修改价格%02zd:%02zd:%02zd",countDown/3600,(countDown/60)%60,countDown%60] forState:UIControlStateNormal];
        }
        if (countDown == 0) {
            if (self.countDownZero) {
                self.countDownZero(self.purchaseOrderEntity);
            }
        }
    }
}


@end
