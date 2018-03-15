//
//  StandardEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "StandardEntity.h"

@implementation StandardEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"valueList" : [valueList class],
             };
}

+ (NSArray *)parseStandardListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (StandardEntity *)parseStandardEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

@end
