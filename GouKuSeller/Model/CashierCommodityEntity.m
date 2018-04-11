//
//  CashierCommodityEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CashierCommodityEntity.h"

@implementation CashierCommodityEntity

+ (NSArray *)parseStandardListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (CashierCommodityEntity *)parseStandardEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

@end
