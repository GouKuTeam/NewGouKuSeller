//
//  AddressEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/15.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AddressEntity.h"

@implementation AddressEntity

+ (NSArray *)parseAddressEntityListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (AddressEntity *)parseAddressEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
