//
//  CommodityChildViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/25.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityFromCodeEntity.h"

typedef enum : int {
    CommodityChildFormNetShop,
    CommodityChildFormShop,
} CommodityChildFormType;

typedef enum : int {
    CommodityChildEnterFormCommodity,
    CommodityChildEnterFormActive,
} CommodityChildEnterFormController;

typedef void(^selectCommodity)(CommodityFromCodeEntity *entity);
@interface CommodityChildViewController : BaseViewController

@property (nonatomic ,assign)CommodityChildFormType   commodityChildFormType;
@property (nonatomic ,assign)CommodityChildEnterFormController   commodityChildEnterFormController;

@property (nonatomic,copy)selectCommodity   selectCommodity;

@end
