//
//  InventoryListEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryListEntity.h"

@implementation InventoryListEntity

+ (NSArray *)parseInventoryListListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (InventoryListEntity *)parseInventoryListEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
    
}
@end
