//
//  SupplierCommodityInformationViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/3.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "StoreEntity.h"
#import "SupplierCommodityEndity.h"

@interface SupplierCommodityInformationViewController : BaseViewController

@property (nonatomic,strong)StoreEntity                *storeEntity;
@property (nonatomic,strong)SupplierCommodityEndity    *supplierCommodityEndity;

@end
