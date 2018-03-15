//
//  StandardEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"
#import "valueList.h"

@interface StandardEntity : BaseEntity

@property (nonatomic ,assign)int            categoryId;
@property (nonatomic ,strong)NSString      *name;
@property (nonatomic ,assign)int            pid;
@property (nonatomic ,strong)NSArray       *valueList;

+ (NSArray *)parseStandardListWithJson:(id)json;
+ (StandardEntity *)parseStandardEntityWithJson:(id)json;
@end
