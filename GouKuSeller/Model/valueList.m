//
//  valueList.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "valueList.h"

@implementation valueList

+ (NSArray *)parsevalueListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (valueList *)parsevalueListEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}


@end
