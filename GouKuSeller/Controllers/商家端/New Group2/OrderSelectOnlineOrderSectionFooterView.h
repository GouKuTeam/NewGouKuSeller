//
//  OrderSelectOnlineOrderSectionFooterView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderEntity.h"

@interface OrderSelectOnlineOrderSectionFooterView : UIView

@property (nonatomic ,strong)UIImageView           *img_line;
@property (nonatomic ,strong)UILabel               *lab_countAndPrice;
@property (nonatomic ,strong)UIButton              *btn_priceDetail;
@property (nonatomic ,strong)UIImageView           *img_line2;

@property (nonatomic ,strong)UILabel               *lab_createTime;
@property (nonatomic ,strong)UILabel               *lab_orderNum;
@property (nonatomic ,strong)UIButton              *btn_copy;
@property (nonatomic ,strong)UIButton              *btn_printer;

@property (nonatomic ,strong)PurchaseOrderEntity   *purchaseOrderEntity;


- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity;

@end
