//
//  wareCategory.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/20.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface wareCategory : BaseEntity

@property (nonatomic ,strong)NSString        *categoryName;

+ (NSArray *)parseWareCategoryWithJson:(id)json;
+ (wareCategory *)parseWareCategoryEntityWithJson:(id)json;

@end
