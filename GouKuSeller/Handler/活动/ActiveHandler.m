//
//  ActiveHandler.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ActiveHandler.h"
#import "ActivityEntity.h"
@implementation ActiveHandler

//新增满减活动
+ (void)addManJianActivityWithSid:(NSNumber *)sid activityType:(NSNumber *)activityType activityName:(NSString *)activityName dateAt:(NSString *)dateAt dateEnd:(NSString *)dateEnd week:(NSArray *)week time:(NSArray *)time manjian:(NSArray *)manjian prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POSTactivityAdd];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POSTactivityAdd];
    NSDictionary *dic = @{
                          @"actCategory":[NSNumber numberWithInt:0],
                          @"actPlatform":[NSNumber numberWithInt:0],
                          @"actType":activityType,
                          @"title":activityName,
                          @"startTime":dateAt,
                          @"endTime":dateEnd,
                          @"weekDays":week,
                          @"times":time,
                          @"rules":manjian
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
//    NSString *str_url = [self requestUrlWithPath:API_POSTactivityAdd];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POSTactivityAdd];

    NSDictionary *dic = @{
                          @"actCategory":[NSNumber numberWithInt:1],
                          @"actPlatform":[NSNumber numberWithInt:0],
                          @"actType":activityType,
                          @"title":activityName,
                          @"startTime":dateAt,
                          @"endTime":dateEnd,
                          @"weekDays":week,
                          @"times":time,
                          @"rules":item
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

+ (void)getActivityListWithActCategory:(NSNumber *)actCategory status:(NSNumber *)status pageNumber:(NSNumber *)pageNumber prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_AllActList];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_AllActList];

    NSDictionary *dic = @{@"actCategory":actCategory,@"status":status,@"pageNumber":pageNumber};
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_data = [ActivityEntity parseActivityListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_data);
                                              }else{
                                                  failed([[responseObject objectForKey:@"errCode"] integerValue],[responseObject objectForKey:@"errMessage"]);
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//停止活动
+ (void)stopActiveWithActiveId:(id)activeId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_POST_STOPACTIVE,activeId]];
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_POST_STOPACTIVE,activeId];

    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  success(nil);
                                              }else{
                                                  failed([[responseObject objectForKey:@"errCode"] integerValue],[responseObject objectForKey:@"errMessage"]);
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
    
}

//查看活动详情
+ (void)selectActiveDetailWithActiveId:(id)activeId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_SELECTACTIVE,activeId]];
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_SELECTACTIVE,activeId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  ActivityEntity *entity = [ActivityEntity parseStandardEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  failed([[responseObject objectForKey:@"errCode"] integerValue],[responseObject objectForKey:@"errMessage"]);
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

@end
