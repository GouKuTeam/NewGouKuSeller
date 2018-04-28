//
//  OrderHandler.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderHandler.h"
#import "OrderListEntity.h"
#import "OrderDetailEntity.h"

@implementation OrderHandler

+ (void)getOrderListWithShopId:(NSNumber *)shopId page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_OrderList];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_OrderList];
    NSDictionary *dic = @{
                          @"page":[NSNumber numberWithInt:page]
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr = [OrderListEntity parseStandardListWithJson:[responseObject objectForKey:@"data"]];
                                                  
                                                  success(arr);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
    
}

//订单详情查询
+ (void)getOrderDetailsWithShopId:(NSNumber *)shopid orderId:(NSString *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_OrderDetail];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_OrderDetail];
    NSDictionary *dic = @{
                          @"shopId":shopid,
                          @"orderId":orderId
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  OrderDetailEntity *entity = [OrderDetailEntity parseStandardEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                              
                                              
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//订单搜索
+ (void)searchOrderWithShopId:(NSNumber *)shopid orderId:(NSString *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_OrderSearch];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_OrderSearch];
    NSDictionary *dic = @{
                          @"shopId":shopid,
                          @"orderId":orderId
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr = [OrderListEntity parseStandardListWithJson:[responseObject objectForKey:@"data"]];
                                                  
                                                  success(arr);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                              
                                              
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}


@end
