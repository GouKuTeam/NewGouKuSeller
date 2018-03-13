//
//  CommodityCatagoryEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/12.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityCatagoryEntity.h"

@implementation CommodityCatagoryEntity

+ (NSArray *)parseCommodityCatagoryListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (CommodityCatagoryEntity *)parseCommodityCatagoryEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
