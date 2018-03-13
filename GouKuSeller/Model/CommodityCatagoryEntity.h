//
//  CommodityCatagoryEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/12.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface CommodityCatagoryEntity : BaseEntity

@property (nonatomic ,strong)NSString           *name;   // 商品名称
@property (nonatomic ,assign)int                 pid; //用于获取下个列表数据的id


+ (NSArray *)parseCommodityCatagoryListWithJson:(id)json;
+ (CommodityCatagoryEntity *)parseCommodityCatagoryEntityWithJson:(id)json;

@end
