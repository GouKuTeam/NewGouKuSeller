//
//  ActivityEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface ActivityEntity : BaseEntity

@property (nonatomic ,strong)NSNumber        *shopId;
@property (nonatomic ,strong)NSNumber        *actCategory;
@property (nonatomic ,strong)NSNumber        *actType;
@property (nonatomic ,strong)NSNumber        *actPlatform;
@property (nonatomic ,strong)NSString        *title;
@property (nonatomic ,assign)double          startTime;
@property (nonatomic ,assign)double          endTime;
@property (nonatomic ,strong)NSString        *actDays;
@property (nonatomic ,strong)NSArray         *weekDays;
@property (nonatomic ,strong)NSArray         *times;
@property (nonatomic ,strong)NSArray         *rules;


+ (NSArray *)parseActivityListWithJson:(id)json;
+ (ActivityEntity *)parseStandardEntityWithJson:(id)json;

@end
