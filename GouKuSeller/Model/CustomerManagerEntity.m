//
//  CustomerManagerEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CustomerManagerEntity.h"

@implementation CustomerManagerEntity

+ (NSArray *)parseCustomerManagerListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (CustomerManagerEntity *)parseCustomerManagerEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
