//
//  SupplierOrderManagerSectionFooterView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderEntity.h"

typedef void(^CountDownZero)(PurchaseOrderEntity *entity);
@interface SupplierOrderManagerSectionFooterView : UIView

@property (nonatomic ,strong)UIImageView           *img_line;
@property (nonatomic ,strong)UILabel               *lab_countAndPrice;
@property (nonatomic ,strong)UIButton              *btn_priceDetail;
@property (nonatomic ,strong)UIButton              *btn_cancelOrder;
@property (nonatomic ,strong)UIButton              *btn_right;
@property (nonatomic ,strong)UIView                *v_order;
@property (nonatomic ,strong)UILabel               *lab_createTimeAndNum;
@property (nonatomic ,strong)UIButton              *btn_copy;
@property (nonatomic ,strong)PurchaseOrderEntity   *purchaseOrderEntity;
@property (nonatomic ,copy)CountDownZero        countDownZero;

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity;

@end
