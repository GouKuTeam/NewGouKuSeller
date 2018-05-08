//
//  WareEntity.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "WareEntity.h"

@implementation WareEntity

+ (NSArray *)parseWareListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (WareEntity *)parseWareEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

@end
