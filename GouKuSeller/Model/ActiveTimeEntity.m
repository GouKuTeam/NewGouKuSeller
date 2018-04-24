//
//  ActiveTimeEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveTimeEntity.h"

@implementation ActiveTimeEntity

+ (NSArray *)parseActivityListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (ActiveTimeEntity *)parseStandardEntityWithJson:(id)json{
    return [self parseObjectWithKeyValues:json];
}


@end
