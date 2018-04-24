//
//  CashierCommodityEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface CashierCommodityEntity : BaseEntity

@property (nonatomic ,strong)NSString   *name;               //商品名称
@property (nonatomic ,strong)NSString   *commodityCount;     //商品数量
@property (nonatomic ,strong)NSString   *standards;          //商品规格
@property (nonatomic ,assign)double      price;              //商品原价
@property (nonatomic ,assign)double      settlementPrice;    //商品应付价格
@property (nonatomic ,assign)double      payMinus;           //满减金额
@property (nonatomic ,assign)int         amount;
@property (nonatomic ,strong)NSNumber    *barcode;
@property (nonatomic ,strong)NSNumber    *skuId;
@property (nonatomic ,strong)NSNumber    *itemActId;       //单品活动id
@property (nonatomic ,strong)NSNumber    *actId;           //整单活动id

+ (NSArray *)parseStandardListWithJson:(id)json;
+ (CashierCommodityEntity *)parseStandardEntityWithJson:(id)json;


@end
