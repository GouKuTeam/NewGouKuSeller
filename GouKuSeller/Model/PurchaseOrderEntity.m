//
//  PurchaseOrderEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseOrderEntity.h"
#import "SupplierCommodityEndity.h"

@implementation PurchaseOrderEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"items" : [SupplierCommodityEndity class],
             @"address": [AddressEntity class],
             };
}

+ (NSArray *)parsePurchaseOrderEntityListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (PurchaseOrderEntity *)parsePurchaseOrderEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
    
}

@end
