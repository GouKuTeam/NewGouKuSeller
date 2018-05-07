//
//  StoreEntity.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "StoreEntity.h"
#import "WareEntity.h"

@implementation StoreEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"shoppingCatItems" : [WareEntity class],
             };
}

+ (NSArray *)parseStoreListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (StoreEntity *)parseStoreEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}
@end
