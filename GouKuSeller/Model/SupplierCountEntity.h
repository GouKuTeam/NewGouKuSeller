//
//  SupplierCountEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface SupplierCountEntity : BaseEntity

@property (nonatomic ,assign)int            allTotal;
@property (nonatomic ,assign)int            obligationTotal;
@property (nonatomic ,assign)int            pendingTotal;

+ (NSArray *)parseSupplierCountEntityListWithJson:(id)json;
+ (SupplierCountEntity *)parseSupplierCountEntityWithJson:(id)json;

@end

/*
 "allTotal":<number>,        //总数量
 "obligationTotal":<number>, //待付款订单数量
 "pendingTotal":<number>     //待发货订单数量
 */
