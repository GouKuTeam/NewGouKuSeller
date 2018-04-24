//
//  ActiveTimeEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/22.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface ActiveTimeEntity : BaseEntity

@property (nonatomic ,strong)NSNumber         *actId;
@property (nonatomic ,assign)double           beginAt;
@property (nonatomic ,assign)double           endAt;

+ (NSArray *)parseActivityListWithJson:(id)json;
+ (ActiveTimeEntity *)parseStandardEntityWithJson:(id)json;

@end
