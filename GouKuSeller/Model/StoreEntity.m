//
//  StoreEntity.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "StoreEntity.h"
#import "SupplierCommodityEndity.h"

@implementation StoreEntity

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"shoppingCatItems" : [SupplierCommodityEndity class],
             };
}

+ (NSArray *)parseStoreListWithJson:(id)json
{
    return [self parseObjectArrayWithKeyValues:json];
}

+ (StoreEntity *)parseStoreEntityWithJson:(id)json
{
    return [self parseObjectWithKeyValues:json];
}

- (id)copyWithZone:(NSZone *)zone {
    
    StoreEntity *entity = [[[self class] allocWithZone:zone] init];
    entity.shopId = self.shopId;
    entity.name = self.name;
    entity.orderNum = self.orderNum;
    entity.shopNum = self.shopNum;
    entity.industry = self.industry;
    entity.agencyBrand = self.agencyBrand;
    entity.logo = self.logo;
    entity.takeOffPrice = self.takeOffPrice;
    entity.isAttention = self.isAttention;
    entity.phone = self.phone;
    entity.orderPrice = self.orderPrice;
    entity.freightPrice = self.freightPrice;
    entity.shoppingCatItems = self.shoppingCatItems;
    entity.isSelected = self.isSelected;
    return entity;
    
}

@end
