//
//  ShoppingHandler.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "ShoppingHandler.h"
#import "ShoppingCarEntity.h"
#import "PurchaseOrderEntity.h"
@implementation ShoppingHandler

//获取购物车列表
+ (void)getShoppingListWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_SHOPPINGLIST];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  ShoppingCarEntity *entity = [ShoppingCarEntity parseShoppingCarEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}
//清空购物车
+ (void)clearShoppingCarWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_DeleteShoppingCar];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  success(nil);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//删除一个购物车商品
+ (void)deleteShopSingleCommodityWithSkuId:(NSNumber *)skuId skuUnitId:(NSNumber *)skuUnitId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_DeleteShoppingInfo];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (skuId) {
        [dic setObject:skuId forKey:@"skuId"];
    }
    if (skuUnitId) {
        [dic setObject:skuUnitId forKey:@"skuUnitId"];
    }
   
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  success(nil);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//删除多个购物车商品
+ (void)deleteShopMoreCommodityWithCommodityArray:(NSArray *)commodityArray prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_DeleteMoreShoppingInfo];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (commodityArray) {
        [dic setObject:commodityArray forKey:@"commodityArray"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  success(nil);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//清空购物车失效商品
+ (void)shoppingRemoveWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_ShoppingRemove];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  success(nil);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//结算生成新订单
+ (void)generateNewOrderWithReceiver:(NSString *)receiver address:(NSString *)address phone:(NSString *)phone items:(NSArray *)items remarks:(NSArray *)remarks prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_NewOrder];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (receiver) {
        [dic setObject:receiver forKey:@"receiver"];
    }
    if (address) {
        [dic setObject:address forKey:@"address"];
    }
    if (phone) {
        [dic setObject:phone forKey:@"phone"];
    }
    if (items.count > 0) {
        [dic setObject:items forKey:@"items"];
    }
    if (remarks.count > 0) {
        [dic setObject:remarks forKey:@"remarks"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  success([responseObject objectForKey:@"data"]);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//查询采购订单列表
+ (void)selectOrderListWithStatus:(NSNumber *)status keyWord:(NSString *)keyWord page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_OrderAndPay,API_POST_ShopOrderList];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (page) {
        [dic setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    }
    if (status) {
        if (status != [NSNumber numberWithInt:999]) {
           [dic setObject:status forKey:@"status"];
        }
    }
    if (keyWord) {
        [dic setObject:keyWord forKey:@"keyWord"];
    }
    
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr = [PurchaseOrderEntity parsePurchaseOrderEntityListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
    
}

//采购订单详情
+ (void)selectShopOrderDetailWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_OrderAndPay,API_GET_ShopOrderDetail,orderId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  PurchaseOrderEntity *entity = [PurchaseOrderEntity parsePurchaseOrderEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//取消采购订单
+ (void)cancelShopOrderDetailWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_OrderAndPay,API_GET_CancelShopOrder,orderId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  success(nil);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//采购订单确认收货
+ (void)confirmShopOrderDetailWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_OrderAndPay,API_GET_ConfirmShopOrder,orderId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
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
