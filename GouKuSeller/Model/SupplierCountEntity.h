//
//  SupplierCountEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface SupplierCountEntity : BaseEntity

@property (nonatomic ,strong)NSNumber       *allTotal;
@property (nonatomic ,strong)NSNumber       *obligationTotal;
@property (nonatomic ,strong)NSNumber       *pendingTotal;

+ (NSArray *)parseSupplierCountEntityListWithJson:(id)json;
+ (SupplierCountEntity *)parseSupplierCountEntityWithJson:(id)json;

@end

/*
 "allTotal":<number>,        //总数量
 "obligationTotal":<number>, //待付款订单数量
 "pendingTotal":<number>     //待发货订单数量
 */
