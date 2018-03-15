//
//  valueList.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface valueList : BaseEntity

@property (nonatomic ,strong)NSString        *value;
@property (nonatomic ,assign)int              standardId;


+ (NSArray *)parsevalueListWithJson:(id)json;
+ (valueList *)parsevalueListEntityWithJson:(id)json;

@end
