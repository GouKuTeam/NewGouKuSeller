//
//  ActiveHandler.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveHandler.h"

@implementation ActiveHandler

//新增满减活动
+ (void)addManJianActivityWithSid:(NSNumber *)sid activityType:(NSNumber *)activityType activityName:(NSString *)activityName dateAt:(NSString *)dateAt dateEnd:(NSString *)dateEnd week:(NSArray *)week time:(NSArray *)time manjian:(NSArray *)manjian prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [self requestUrlWithPath:API_POSTactivityAdd];
    NSDictionary *dic = @{
                          @"sid":sid,
                          @"activityType":activityType,
                          @"activityName":activityName,
                          @"dateAt":dateAt,
                          @"dateEnd":dateEnd,
                          @"week":week,
                          @"time":time,
                          @"manjian":manjian
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  
                                                  success(responseObject);
                                                  
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                              
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}


//新增折扣  立减  特价  活动
+ (void)addOtherActivityWithSid:(NSNumber *)sid activityType:(NSNumber *)activityType activityName:(NSString *)activityName dateAt:(NSString *)dateAt dateEnd:(NSString *)dateEnd week:(NSArray *)week time:(NSArray *)time item:(NSArray *)item prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [self requestUrlWithPath:API_POSTactivityAdd];
    NSDictionary *dic = @{
                          @"sid":sid,
                          @"activityType":activityType,
                          @"activityName":activityName,
                          @"dateAt":dateAt,
                          @"dateEnd":dateEnd,
                          @"week":week,
                          @"time":time,
                          @"item":item
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              success(responseObject);
                                              
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

@end
