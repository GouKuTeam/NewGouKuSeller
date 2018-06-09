//
//  ShopOutOrderCountEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface ShopOutOrderCountEntity : BaseEntity

@property (nonatomic ,assign)int            newOrderCount;
@property (nonatomic ,assign)int            hadleOrderCount;
@property (nonatomic ,assign)int            cleseOrderCount;
@property (nonatomic ,assign)int            allOrderCount;

+ (NSArray *)parseShopOutOrderCountEntityListWithJson:(id)json;
+ (ShopOutOrderCountEntity *)parseShopOutOrderCountEntityWithJson:(id)json;

@end


/*
 "newOrderCount": <number>,          //新订单数量
 "hadleOrderCount": <number>,        //待处理订单数量
 "cleseOrderCount": <number>,        //待关闭订单数量
 "allOrderCount": <number>           //总数量
 */
