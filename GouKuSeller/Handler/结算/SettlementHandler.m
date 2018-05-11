//
//  SettlementHandler.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "SettlementHandler.h"
#import "AccountCashEntity.h"
#import "AccountCashDetailEntity.h"

@implementation SettlementHandler

//结算首页信息
+(void)accountshowWithshopId:(NSNumber *)shopId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_AccountShow];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_AccountShow];
//    NSDictionary *dic = @{@"shopId":shopId};
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  AccountCashEntity *data = [AccountCashEntity parseStandardEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(data);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                              
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+(void)accountdetailsWithshopId:(NSNumber *)shopId page:(int)page type:(int)type prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_AccountDetails];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_AccountDetails];
    NSDictionary *dic = @{
                          @"shopId":shopId,
                          @"page":[NSNumber numberWithInt:page],
                          @"accountType":[NSNumber numberWithInt:type]
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSLog(@"%@",[responseObject objectForKey:@"data"]);
                                                  NSArray *arr = [AccountCashDetailEntity parseStandardListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                              
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+(void)getbankListprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_bankMessage];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_bankMessage];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSLog(@"%@",[responseObject objectForKey:@"data"]);
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

//获取验证码
+(void)getAccountCodeWithphoneNum:(NSString *)phoneNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_AccountCode];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_AccountCode];
    NSDictionary *dic = @{
                          @"phone":phoneNum
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  [MBProgressHUD showInfoMessage:@"发送成功"];
                                                  success(responseObject);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                              
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}
//添加银行卡
+(void)addBankCardWithBankDic:(NSDictionary *)dic prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_addBankCard];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_addBankCard];
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

+(void)checkPassWordWithshopId:(NSNumber *)shopId cardNum:(NSString *)cardNum money:(double)money username:(NSString *)username password:(NSString *)password prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_checkPassword];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_checkPassword];
    NSDictionary *dic = @{
                          @"shopId":shopId,
                          @"cardNum":cardNum,
                          @"money":[NSNumber numberWithDouble:money],
                          @"username":username,
                          @"password":password
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

//提现详情
+(void)cashDetailWithShopId:(NSNumber *)shopid cashOrderId:(NSString *)cashOrderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_CashDetail];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_CashDetail];
    NSDictionary *dic = @{
                          @"shopId":shopid,
                          @"cashOrderId":cashOrderId
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSLog(@"%@",[responseObject objectForKey:@"data"]);
                                                  AccountCashDetailEntity *entity = [AccountCashDetailEntity parseStandardEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//微信充值
+(void)weixinchongzhiWithPrice:(NSString *)price prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_WEIXINchongzhi];
    NSDictionary *dic = @{
                          @"sum":price
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
