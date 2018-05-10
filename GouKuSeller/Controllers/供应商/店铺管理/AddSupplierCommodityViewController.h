//
//  AddSupplierCommodityViewController.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseViewController.h"
#import "CommodityFromCodeEntity.h"
#import "SupplierCommodityEndity.h"
typedef void(^changeEntity)(SupplierCommodityEndity *entity);
typedef void(^addCommodityFinish)(void);

@interface AddSupplierCommodityViewController : BaseViewController

@property (nonatomic ,strong)NSString       *comeFrom;
@property (nonatomic ,strong)NSNumber       *barcode;
@property (nonatomic ,strong)NSNumber       *skuId;
@property (nonatomic ,strong)CommodityFromCodeEntity    *entityInformation;
@property (nonatomic, copy) changeEntity  changeEntity;
@property (nonatomic, copy) addCommodityFinish  addCommodityFinish;
@property (nonatomic ,assign)int             hitType;


@end
