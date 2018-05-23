//
//  SupplierPriceDetailView.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/23.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOrderEntity.h"

@interface SupplierPriceDetailView : UIView

@property (nonatomic ,strong)UIView            *v_back;
@property (nonatomic ,strong)UILabel           *lab_totalPrice;
@property (nonatomic ,strong)UILabel           *lab_yunfei;
@property (nonatomic ,strong)UILabel           *lab_yuanjia;
@property (nonatomic ,strong)UILabel           *lab_changePrice;
@property (nonatomic ,strong)UILabel           *lab_totalPriceDetail;
@property (nonatomic ,strong)UILabel           *lab_yunfeiDetail;
@property (nonatomic ,strong)UILabel           *lab_yuanjiaDetail;
@property (nonatomic ,strong)UILabel           *lab_changePriceDetail;
@property (nonatomic ,strong)UIImageView       *img_line;
@property (nonatomic ,strong)UIButton          *btn_sure;

- (void)contentViewWithPurchaseOrderEntity:(PurchaseOrderEntity *)purchaseOrderEntity;

@end
