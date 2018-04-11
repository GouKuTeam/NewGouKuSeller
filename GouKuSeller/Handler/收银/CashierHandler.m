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
+(void)commodityCashierWithBarcode:(NSString *)barcode shopId:(NSNumber *)shopid addup:(double)addup prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSString *str_url = [self requestUrlWithPath:API_POST_CommodityCashier];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (shopid) {
        [dic setObject:shopid forKey:@"shopId"];
    }
    if (barcode) {
        [dic setObject:barcode forKey:@"barcode"];
    }
    if (addup) {
        [dic setObject:[NSNumber numberWithDouble:addup] forKey:@"addup"];
    }
    
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  CashierCommodityEntity *entity = [CashierCommodityEntity parseStandardEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//添加订单
+(void)addOrderWithShopId:(NSNumber *)shopid items:(NSArray *)items payTotal:(double)payTotal payReduce:(double)payReduce payActual:(double)payActual noGoods:(double)noGoods payType:(int)payType orderDiscount:(double)orderDiscount orderMinus:(double)orderMinus loseSmallReduce:(double)loseSmallReduce prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [self requestUrlWithPath:API_POST_AddOrder];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (shopid) {
        [dic setObject:shopid forKey:@"shopId"];
    }
    if (items) {
        //商品数组
        [dic setObject:items forKey:@"items"];
    }
    if (payTotal) {
        //总额
        [dic setObject:[NSNumber numberWithDouble:payTotal] forKey:@"payTotal"];
    }
    if (payReduce) {
        //优惠金额
        [dic setObject:[NSNumber numberWithDouble:payReduce] forKey:@"payReduce"];
    }
    if (payActual) {
        //实付金额
        [dic setObject:[NSNumber numberWithDouble:payActual] forKey:@"payActual"];
    }
    if (noGoods) {
        //无码商品
        [dic setObject:[NSNumber numberWithDouble:noGoods] forKey:@"noGoods"];
    }
    if (payType) {
        //支付方式  1 微信 2 现金
        [dic setObject:[NSNumber numberWithInt:payType] forKey:@"payType"];
    }
    if (orderDiscount) {
        //整单折扣
        [dic setObject:[NSNumber numberWithDouble:orderDiscount] forKey:@"orderDiscount"];
    }
    if (orderMinus) {
        //整单减价
        [dic setObject:[NSNumber numberWithDouble:orderMinus] forKey:@"orderMinus"];
    }
    if (loseSmallReduce) {
        //去零
        [dic setObject:[NSNumber numberWithDouble:loseSmallReduce] forKey:@"loseSmallReduce"];
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
    NSString *str_url = [self requestUrlWithPath:API_POST_ScanUserCashCode];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (openid) {
        [dic setObject:openid forKey:@"openid"];
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

@end
