//
//  wareCategory.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "wareCategory.h"

@implementation wareCategory

+ (NSArray *)parseWareCategoryWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (wareCategory *)parseWareCategoryEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
