//
//  BankCardEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BankCardEntity.h"

@implementation BankCardEntity


+ (NSArray *)parseWareCategoryWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (BankCardEntity *)parseWareCategoryEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
