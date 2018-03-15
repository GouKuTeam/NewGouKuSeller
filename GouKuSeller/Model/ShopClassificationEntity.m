//
//  ShopClassificationEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopClassificationEntity.h"

@implementation ShopClassificationEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"childList":[ShopClassificationEntity class],
             };
}

+ (NSArray *)parseShopClassificationListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (ShopClassificationEntity *)parseShopClassificationEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

@end
