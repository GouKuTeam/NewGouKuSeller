//
//  ShoppingCarEntity.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShoppingCarEntity.h"
#import "SupplierCommodityEndity.h"
#import "StoreEntity.h"
@implementation ShoppingCarEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"shoppingCarShops" : [StoreEntity class],
             @"invalidItems":[SupplierCommodityEndity class],
             };
}

+ (ShoppingCarEntity *)parseShoppingCarEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}
@end
