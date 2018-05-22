//
//  SupplierCountEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierCountEntity.h"

@implementation SupplierCountEntity

+ (NSArray *)parseSupplierCountEntityListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (SupplierCountEntity *)parseSupplierCountEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
