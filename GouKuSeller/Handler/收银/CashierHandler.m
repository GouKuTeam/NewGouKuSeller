//
//  CashierHandler.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CashierHandler.h"
#import "CashierCommodityEntity.h"

@implementation CashierHandler 

//扫描商品条形码加入购物车  (dic 包含barcode  shopId   addup(合计金额))
+(void)commodityCashierWithBarcode:(NSString *)barcode shopId:(NSNumber *)shopid addup:(NSString *)addup prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
//    NSString *str_url = [self requestUrlWithPath:API_POST_CommodityCashier];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_CommodityCashier];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (shopid) {
        [dic setObject:shopid forKey:@"shopId"];
    }
    if (barcode) {
        [dic setObject:barcode forKey:@"barcode"];
    }
    if (addup) {
        [dic setObject:addup forKey:@"addup"];
    }
    
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

//添加订单
+(void)addOrderWithShopId:(NSNumber *)shopid items:(NSArray *)items payTotal:(NSString *)payTotal payReduce:(NSString *)payReduce payActual:(NSString *)payActual noGoods:(NSString *)noGoods payType:(int)payType orderDiscount:(NSString *)orderDiscount orderMinus:(NSString *)orderMinus loseSmallReduce:(NSString *)loseSmallReduce actId:(NSNumber *)actId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_AddOrder];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_AddOrder];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (shopid) {
        [dic setObject:shopid forKey:@"shopId"];
    }
    if (items) {
        //商品数组
        if (items.count > 0) {
            [dic setObject:items forKey:@"items"];
        }
    }
    if (payTotal) {
        //总额
        [dic setObject:payTotal forKey:@"payTotal"];
    }
    if (payReduce) {
        //优惠金额
        if ([payReduce doubleValue] > 0) {
            [dic setObject:payReduce forKey:@"payReduce"];
        }
    }
    if (payActual) {
        //实付金额
        [dic setObject:payActual forKey:@"payActual"];
    }
    if (noGoods) {
        //无码商品
        [dic setObject:noGoods forKey:@"noGoods"];
    }
    if (payType) {
        //支付方式  1 微信 2 现金
        [dic setObject:[NSNumber numberWithInt:payType] forKey:@"payType"];
    }
    if (orderDiscount) {
        //整单折扣
        [dic setObject:orderDiscount forKey:@"orderDiscount"];
    }
    if (orderMinus) {
        //整单减价
        [dic setObject:orderMinus forKey:@"orderMinus"];
    }
    if (loseSmallReduce) {
        //去零
        [dic setObject:loseSmallReduce forKey:@"loseSmallReduce"];
    }
    if (actId) {
        [dic setObject:actId forKey:@"actId"];
    }
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

//扫描用户付款码
+(void)scanUserCashCodeWithOpenId:(NSString *)openid orderId:(NSString *)orderid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_POST_ScanUserCashCode];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_ScanUserCashCode];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (openid) {
        [dic setObject:openid forKey:@"payCode"];
    }
    if (orderid) {
        [dic setObject:orderid forKey:@"orderId"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  
                                                  success(nil);
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//查询满减金额
+(void)selectManJianPriceWithaddup:(NSString *)addup prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_SelectManJianPrice];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (addup) {
        [dic setObject:addup forKey:@"addup"];
    }

    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  NSDictionary *dic = [responseObject objectForKey:@"data"];
                                                  success(dic);
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
    
}

//现金收银
+(void)payInCashWithOrderId:(NSString *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_OrderAndPay,API_POST_PayInCash,orderId];

    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  success(nil);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

@end
