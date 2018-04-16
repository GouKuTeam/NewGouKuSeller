//
//  ItemsEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ItemsEntity.h"

@implementation ItemsEntity

+ (NSArray *)parseStandardListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (ItemsEntity *)parseStandardEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}

@end
