//
//  ShopPriceDetailView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderEntity.h"

@interface ShopPriceDetailView : UIView

@property (nonatomic ,strong)UIView            *v_back;
@property (nonatomic ,strong)UILabel           *lab_totalPrice;
@property (nonatomic ,strong)UILabel           *lab_youhui;
@property (nonatomic ,strong)UILabel           *lab_shouru;

@property (nonatomic ,strong)UILabel           *lab_totalPriceDetail;
@property (nonatomic ,strong)UILabel           *lab_youhuiDetail;
@property (nonatomic ,strong)UILabel           *lab_shouruDetail;
@property (nonatomic ,strong)UIImageView       *img_line;
@property (nonatomic ,strong)UIButton          *btn_sure;

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity;

@end
