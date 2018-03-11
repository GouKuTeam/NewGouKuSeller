//
//  CommodityInformationEntity.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityInformationEntity.h"

@implementation CommodityInformationEntity

+ (NSArray *)parseCommodityInformationListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (CommodityInformationEntity *)parseCommodityInformationEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}


@end

