//
//  SupplierCommodityEndity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SupplierCommodityEndity.h"

@implementation SupplierCommodityEndity

+ (NSArray *)parseSupplierCommodityEndityListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (SupplierCommodityEndity *)parseSupplierCommodityEndityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

@end
