//
//  CategoryEntity.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface CategoryEntity : BaseEntity

@property (nonatomic,strong)NSNumber        *industryId;
@property (nonatomic,strong)NSString        *industryName;

+ (NSArray *)parseCategoryListWithJson:(id)json;

@end
