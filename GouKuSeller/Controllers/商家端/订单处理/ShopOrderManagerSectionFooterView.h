//
//  ShopOrderManagerSectionFooterView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderEntity.h"

typedef void(^CountDownZero)(PurchaseOrderEntity *entity);
@interface ShopOrderManagerSectionFooterView : UIView

@property (nonatomic ,strong)UIImageView           *img_line;
@property (nonatomic ,strong)UILabel               *lab_countAndPrice;
@property (nonatomic ,strong)UIButton              *btn_priceDetail;
@property (nonatomic ,strong)UIImageView           *img_line2;
@property (nonatomic ,strong)UILabel               *lab_userCancelTime;
@property (nonatomic ,strong)UILabel               *lab_userCancelTitle;
@property (nonatomic ,strong)UILabel               *lab_userCancelReason;
@property (nonatomic ,strong)UIButton              *btn_right;
@property (nonatomic ,strong)UIImageView           *img_line3;
@property (nonatomic ,strong)UILabel               *lab_createTime;
@property (nonatomic ,strong)UILabel               *lab_orderNum;
@property (nonatomic ,strong)UIButton              *btn_copy;
@property (nonatomic ,strong)UIButton              *btn_printer;

@property (nonatomic ,strong)PurchaseOrderEntity   *purchaseOrderEntity;
@property (nonatomic ,copy)CountDownZero        countDownZero;

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity;

@end
