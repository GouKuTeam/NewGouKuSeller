//
//  ShopOrderManagerSectionFooterView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopOrderManagerSectionFooterView.h"
#import "CountDownManager.h"
#import "DateUtils.h"

@implementation ShopOrderManagerSectionFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(countDownNotfifcation) name:kCountDownNotification object:nil];
        self.backgroundColor = [UIColor whiteColor];
        self.img_line = [[UIImageView alloc]init];
        [self addSubview:self.img_line];
//        [self.img_line setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
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
        
        self.lab_userCancelTime = [[UILabel alloc]init];
        [self addSubview:self.lab_userCancelTime];
        [self.lab_userCancelTime setFont:[UIFont systemFontOfSize:16]];
        [self.lab_userCancelTime setTextColor:[UIColor blackColor]];
        [self.lab_userCancelTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.img_line2.mas_bottom).offset(10);
            make.height.mas_equalTo(22);
        }];
        
        self.lab_userCancelTitle = [[UILabel alloc]init];
        [self addSubview:self.lab_userCancelTitle];
        [self.lab_userCancelTitle setFont:[UIFont systemFontOfSize:16]];
        [self.lab_userCancelTitle setTextColor:[UIColor blackColor]];
        [self.lab_userCancelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_userCancelTime.mas_right).offset(20);
            make.top.height.equalTo(self.lab_userCancelTime);
        }];
        
        self.lab_userCancelReason = [[UILabel alloc]init];
        [self addSubview:self.lab_userCancelReason];
        [self.lab_userCancelReason setFont:[UIFont systemFontOfSize:16]];
        [self.lab_userCancelReason setTextColor:[UIColor blackColor]];
        [self.lab_userCancelReason mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lab_userCancelTitle);
            make.top.equalTo(self.lab_userCancelTitle.mas_bottom).offset(2);
            make.height.equalTo(self.lab_userCancelTitle);
        }];
        
        self.btn_right = [[UIButton alloc]init];
        [self addSubview:self.btn_right];
        [self.btn_right setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [self.btn_right setBackgroundColor:[UIColor colorWithHexString:@"#4167B2"]];
        self.btn_right.titleLabel.font = [UIFont systemFontOfSize:16];
        self.btn_right.layer.cornerRadius = 3.0f;
        [self.btn_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 243 - 15);
            make.top.equalTo(self.lab_userCancelReason.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-15.1);
            make.height.mas_equalTo(38);
        }];
        
        self.img_line3 = [[UIImageView alloc]init];
        [self addSubview:self.img_line3];
        [self.img_line3 setBackgroundColor:[UIColor colorWithHexString:@"#D8D8D8"]];
        [self.img_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.btn_right.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        
        self.lab_createTime = [[UILabel alloc]init];
        [self addSubview:self.lab_createTime];
        [self.lab_createTime setFont:[UIFont systemFontOfSize:12]];
        [self.lab_createTime setTextColor:[UIColor colorWithHexString:@"#959595"]];
        [self.lab_createTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.img_line);
            make.top.equalTo(self.img_line3.mas_bottom).offset(10);
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
    if ((purchaseOrderEntity.status == 1) && (purchaseOrderEntity.refund == 0)) {
        [self.img_line2 setHidden:YES];
        [self.lab_userCancelTime setHidden:YES];
        [self.lab_userCancelTitle setHidden:YES];
        [self.lab_userCancelReason setHidden:YES];
        [self.btn_right setHidden:NO];
        [self.btn_right mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH - 243 - 15);
            make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-15.1);
        }];
        [self.img_line3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.btn_right.mas_bottom).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
        [self.btn_right setTitle:[NSString stringWithFormat:@"接单 %02zd:%02zd",(purchaseOrderEntity.countDown/60)%60,purchaseOrderEntity.countDown%60] forState:UIControlStateNormal];
    }else if ((purchaseOrderEntity.status == 2 || purchaseOrderEntity.status == 4 || purchaseOrderEntity.status == 5 || purchaseOrderEntity.status == 6 || purchaseOrderEntity.status == 8) && (purchaseOrderEntity.refund == 0)){
        [self.img_line2 setHidden:YES];
        [self.lab_userCancelTime setHidden:YES];
        [self.lab_userCancelTitle setHidden:YES];
        [self.lab_userCancelReason setHidden:YES];
        [self.btn_right setHidden:YES];
        [self.img_line3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(6);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
    }else{
        
        if (purchaseOrderEntity.refund == 1) {
            [self.lab_userCancelTitle setText:@"用户已退款"];
            //此时按钮显示我知道了   不需要进行倒计时
            [self.btn_right setTitle:@"我知道了" forState:UIControlStateNormal];
        }else{
            //用户取消  时间  原因   状态
            if (purchaseOrderEntity.refund == 1) {
                [self.lab_userCancelTitle setText:@"用户已退款"];
                //此时按钮显示我知道了   不需要进行倒计时
                [self.btn_right setTitle:@"我知道了" forState:UIControlStateNormal];
            }else{
                [self.lab_userCancelTitle setText:@"用户申请退款"];
                //此时按钮显示倒计时
                [self.btn_right setTitle:[NSString stringWithFormat:@"同意取消 %02zd:%02zd:%02zd",purchaseOrderEntity.countDown/3600,(purchaseOrderEntity.countDown/60)%60,purchaseOrderEntity.countDown%60] forState:UIControlStateNormal];
            }
            [self.btn_right setHidden:NO];
            [self.lab_userCancelReason setText:[NSString stringWithFormat:@"取消原因：%@",purchaseOrderEntity.refundReasons]];
        }
        [self.lab_userCancelTime setText:[NSString stringWithFormat:@"%@",[DateUtils stringFromTimeInterval:purchaseOrderEntity.refundAt formatter:@"HH:mm"]]];
    }
    
    
    [self.img_line2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self.lab_countAndPrice.mas_bottom).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
    }];
    [self.img_line3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self.btn_right.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0.5);
    }];
    [self.img_line2 setHidden:NO];
    [self.lab_userCancelTime setHidden:NO];
    [self.lab_userCancelTitle setHidden:NO];
    [self.lab_userCancelReason setHidden:NO];
    [self.lab_createTime setText:[NSString stringWithFormat:@"%@下单",[DateUtils stringFromTimeInterval:purchaseOrderEntity.createTime formatter:@"MM-dd HH:mm"]]];
    [self.lab_orderNum setText:[NSString stringWithFormat:@"订单编号:%@",purchaseOrderEntity.orderId]];
    self.purchaseOrderEntity = purchaseOrderEntity;
}

- (void)countDownNotfifcation{
    if (self.purchaseOrderEntity.status == 1) {
        NSInteger countDown = self.purchaseOrderEntity.countDown - 1;
        self.purchaseOrderEntity.countDown = self.purchaseOrderEntity.countDown - 1;
        if (countDown < 0) {
        }else{
            [self.btn_right setTitle:[NSString stringWithFormat:@"接单 %02zd:%02zd",(countDown/60)%60,countDown%60] forState:UIControlStateNormal];
            
        }
        if (countDown == 0) {
            if (self.countDownZero) {
                self.countDownZero(self.purchaseOrderEntity);
            }
        }
    }
}

@end
