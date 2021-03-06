//
//  PublishCommodityViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityFromCodeEntity.h"

typedef enum : int {
    PublishCommodityFormPublish,
    PublishCommodityFormEdit,
} PublishCommodityFormType;

typedef enum {
    PublishCommodityToShop = 1,
    PublishCommodityToNetShop = 2,
} PublishCommodityToShopType;

typedef void(^changeChildEntity)(CommodityFromCodeEntity *entity);

@interface PublishCommodityViewController : BaseViewController

@property (nonatomic ,strong)CommodityFromCodeEntity    *entityInformation;

@property (nonatomic ,assign)PublishCommodityFormType    publishCommodityFormType;

@property (nonatomic ,assign)PublishCommodityToShopType    publishCommodityToShopType;

@property (nonatomic, copy  )changeChildEntity  changeChildEntity;


@end
