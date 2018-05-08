//
//  SupplierCommodityViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityFromCodeEntity.h"
#import "SearchCommodityViewController.h"

typedef void(^selectCommodity)(CommodityFromCodeEntity *entity);

@interface SupplierCommodityViewController : BaseViewController

@property (nonatomic,assign)EnterFormType   enterFormType;
@property (nonatomic,copy)selectCommodity   selectCommodity;

@end
