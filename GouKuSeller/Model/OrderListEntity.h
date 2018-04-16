//
//  OrderListEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"
#import "OrderDetailEntity.h"

@interface OrderListEntity : BaseEntity

@property (nonatomic ,strong)NSArray               *orderList;
@property (nonatomic ,assign)double                payDate;   //支付时间

+ (NSArray *)parseStandardListWithJson:(id)json;
+ (OrderListEntity *)parseStandardEntityWithJson:(id)json;
@end
