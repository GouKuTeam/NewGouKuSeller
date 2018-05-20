//
//  PurchaseOrderDetailBottomView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderEntity.h"

@interface PurchaseOrderDetailBottomView : UIView

@property (nonatomic ,strong)UIView          *v_top;
@property (nonatomic ,strong)UIButton        *btn_tell;
@property (nonatomic ,strong)UIView          *v_orderAndTime;
@property (nonatomic ,strong)UIButton        *btn_copy;
@property (nonatomic ,strong)UILabel         *lab_orderCode;
@property (nonatomic ,strong)UILabel         *lab_creatTime;

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)entity;

@end
