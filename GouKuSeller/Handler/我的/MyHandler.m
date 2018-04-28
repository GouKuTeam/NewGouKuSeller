//
//  MyHandler.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "MyHandler.h"

@implementation MyHandler
+(void)mineShopListWithAccount:(NSString *)account prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = @"http://47.97.174.40:9000/mine/shoplist";
    NSString *str_url = [NSString stringWithFormat:@"%@/mine/shoplist",API_Login];
    NSDictionary *dic = @{
                          @"account":account
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr = [responseObject objectForKey:@"data"];
                                                  
                                                  success(arr);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+(void)getTodayMsgprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_GET_GetToday];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_GET_GetToday];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSDictionary *dic = [responseObject objectForKey:@"data"];
                                                  success(dic);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}
@end
