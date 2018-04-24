//
//  ActivityEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActivityEntity.h"
#import "ActiveTimeEntity.h"
#import "ActiveRulesEntity.h"

@implementation ActivityEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"times" : [ActiveTimeEntity class],
             @"rules" : [ActiveRulesEntity class]
             };
}

+ (NSArray *)parseActivityListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (ActivityEntity *)parseStandardEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

@end
