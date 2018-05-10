//
//  CategoryEntity.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CategoryEntity.h"

@implementation CategoryEntity

+ (NSArray *)parseCategoryListWithJson:(id)json{
    return [self parseObjectArrayWithKeyValues:json];
}

@end
