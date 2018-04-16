//
//  OrderDetailEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderDetailEntity.h"
#import "ItemsEntity.h"

@implementation OrderDetailEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"items" : [ItemsEntity class],
             };
}

+ (NSArray *)parseStandardListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (OrderDetailEntity *)parseStandardEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

@end
