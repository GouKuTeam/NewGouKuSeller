//
//  InventoryEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryEntity.h"

@implementation InventoryEntity

+ (NSArray *)parseInventoryListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (InventoryEntity *)parseInventoryEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
