//
//  ShopOutOrderCountEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/6/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShopOutOrderCountEntity.h"

@implementation ShopOutOrderCountEntity

+ (NSArray *)parseShopOutOrderCountEntityListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (ShopOutOrderCountEntity *)parseShopOutOrderCountEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
