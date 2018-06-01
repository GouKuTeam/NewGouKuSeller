//
//  PurchaseOrderDetailBottomView.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseOrderDetailBottomView.h"
#import "DateUtils.h"

@implementation PurchaseOrderDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.v_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [self addSubview:self.v_top];
        [self.v_top setBackgroundColor:[UIColor colorWithHexString:COLOR_GRAY_BG]];
        
        self.btn_tell = [[UIButton alloc]initWithFrame:CGRectMake(0,self.v_top.bottom, SCREEN_WIDTH , 44)];
        [self addSubview:self.btn_tell];
        [self.btn_tell setBackgroundColor:[UIColor whiteColor]];
        [self.btn_tell setTitle:@"联系供应商" forState:UIControlStateNormal];
        [self.btn_tell setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
        [self.btn_tell setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
        [self.btn_tell setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        self.btn_tell.titleLabel.font = [UIFont systemFontOfSize:16];
        
        self.v_orderAndTime = [[UIView alloc]initWithFrame:CGRectMake(0, self.btn_tell.bottom + 10, SCREEN_WIDTH, 60)];
        [self addSubview:self.v_orderAndTime];
        [self.v_orderAndTime setBackgroundColor:[UIColor whiteColor]];
        
        self.lab_orderCode = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 280, 20)];
        [self.v_orderAndTime addSubview:self.lab_orderCode];
        [self.lab_orderCode setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_orderCode setFont:[UIFont systemFontOfSize:14]];
        
        self.lab_creatTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 34, SCREEN_WIDTH - 20, 20)];
        [self.v_orderAndTime addSubview:self.lab_creatTime];
        [self.lab_creatTime setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_creatTime setFont:[UIFont systemFontOfSize:14]];
        
        
        self.btn_copy = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 42, 12, 30, 20)];
        [self.v_orderAndTime addSubview:self.btn_copy];
        [self.btn_copy setTitle:@"复制" forState:UIControlStateNormal];
        [self.btn_copy setTitleColor:[UIColor colorWithHexString:@"#4167B2"] forState:UIControlStateNormal];
        self.btn_copy.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
 
    }
    return self;
}

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)entity{
    [self.lab_orderCode setText:[NSString stringWithFormat:@"订单编号：%@",entity.orderId]];
    
    if (entity.payTime == 0) {
       [self.lab_creatTime setText:[NSString stringWithFormat:@"创建时间：%@",[DateUtils stringFromTimeInterval:entity.createTime formatter:@"yyyy-MM-dd HH:mm:ss"]]];
    }else{
        [self.lab_creatTime setText:[NSString stringWithFormat:@"付款时间：%@",[DateUtils stringFromTimeInterval:entity.payTime formatter:@"yyyy-MM-dd HH:mm:ss"]]];
    }
}

@end
