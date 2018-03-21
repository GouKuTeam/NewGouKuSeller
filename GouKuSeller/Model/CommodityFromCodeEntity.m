//
//  CommodityFromCodeEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityFromCodeEntity.h"


@implementation CommodityFromCodeEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"wareCategory" : [wareCategory class],
             };
}

+ (NSArray *)parseCommodityFromCodeListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (CommodityFromCodeEntity *)parseCommodityFromCodeEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}
@end
