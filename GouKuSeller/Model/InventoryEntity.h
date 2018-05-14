//
//  InventoryEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface InventoryEntity : BaseEntity

@property (nonatomic ,strong)NSNumber       *skuId;            //商品SKUID
@property (nonatomic ,assign)int             stock;            //库存
@property (nonatomic ,assign)int             inventoryNum;     //盘点数目
@property (nonatomic ,strong)NSString       *name;             //名称

+ (NSArray *)parseInventoryListWithJson:(id)json;
+ (InventoryEntity *)parseInventoryEntityWithJson:(id)json;

@end
