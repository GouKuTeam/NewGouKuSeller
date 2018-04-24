//
//  ActiveRulesEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface ActiveRulesEntity : BaseEntity
@property (nonatomic ,strong)NSNumber        *actId;           //活动ID
@property (nonatomic ,strong)NSNumber        *shopId;          //商家ID
@property (nonatomic ,strong)NSNumber        *skuId;           //商品ID(可能为空)
@property (nonatomic ,strong)NSString        *wareName;        //商品名称(可能为空)
@property (nonatomic ,assign)double          wareOprice;       //商品价格(可能为空)
@property (nonatomic ,assign)double          fullPrice;        //满金额
@property (nonatomic ,assign)double          minusPrice;       //减金额
@property (nonatomic ,assign)double          favorablePrive;   //优惠金额
@property (nonatomic ,assign)double          discount;         //折扣
@property (nonatomic ,assign)double          wareMinusPrice;   //立减金额
@property (nonatomic ,strong)NSString        *actExtent;       //扩展字段

+ (NSArray *)parseActivityListWithJson:(id)json;
+ (ActiveRulesEntity *)parseStandardEntityWithJson:(id)json;

@end

