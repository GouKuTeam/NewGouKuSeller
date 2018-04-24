//
//  ActiveHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface ActiveHandler : BaseHandler

//新增满减活动
+ (void)addManJianActivityWithSid:(NSNumber *)sid activityType:(NSNumber *)activityType activityName:(NSString *)activityName dateAt:(NSString *)dateAt dateEnd:(NSString *)dateEnd week:(NSArray *)week time:(NSArray *)time manjian:(NSArray *)manjian prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//新增折扣  立减  特价  活动
+ (void)addOtherActivityWithSid:(NSNumber *)sid activityType:(NSNumber *)activityType activityName:(NSString *)activityName dateAt:(NSString *)dateAt dateEnd:(NSString *)dateEnd week:(NSArray *)week time:(NSArray *)time item:(NSArray *)item prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查看所有活动列表
+ (void)getActivityListWithActCategory:(NSNumber *)actCategory status:(NSNumber *)status pageNumber:(NSNumber *)pageNumber prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//停止活动
+ (void)stopActiveWithActiveId:(id)activeId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查看活动详情
+ (void)selectActiveDetailWithActiveId:(id)activeId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
