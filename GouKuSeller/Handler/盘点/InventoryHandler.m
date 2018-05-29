//
//  InventoryHandler.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "InventoryHandler.h"
#import "InventoryEntity.h"
#import "InventoryListEntity.h"

@implementation InventoryHandler

//根据条形码获取商品详情
+ (void)selectInventoryWareInventoryInformationWithBarcode:(NSString *)barcode prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_POST_SelectInventoryInformation,barcode];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              success(responseObject);
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//查询盘点记录列表
+ (void)inventroyListWithPage:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_InventroyList,[NSNumber numberWithInt:page]];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_date = [InventoryListEntity parseInventoryListListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_date);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//盘点记录新增
+ (void)addInventoryWithTitle:(NSString *)title status:(NSNumber *)status wares:(NSArray *)wares prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_AddInventory];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (title) {
        [dic setObject:title forKey:@"title"];
    }
    if (status) {
        [dic setObject:status forKey:@"status"];
    }
    if (wares) {
        [dic setObject:wares forKey:@"wares"];
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

//删除一条盘点记录
+ (void)deleteInventroyWithInventroyId:(NSNumber *)inventoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_DeleteInventory,inventoryId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              success(responseObject);
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}
//查询一条盘点记录
+ (void)selectInventroyDetailWithInventroyId:(NSNumber *)inventoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
   NSString *str_url = [NSString stringWithFormat:@"%@%@/%@",API_Other,API_GET_SelectInventoryDetail,inventoryId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  InventoryListEntity *entity = [InventoryListEntity parseInventoryListEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//盘点记录修改
+ (void)updateInventoryWithInventoryId:(NSNumber *)inventoryId Title:(NSString *)title status:(NSNumber *)status wares:(NSArray *)wares prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_AddInventory];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (inventoryId) {
        [dic setObject:inventoryId forKey:@"id"];
    }
    if (title) {
        [dic setObject:title forKey:@"title"];
    }
    if (status) {
        [dic setObject:status forKey:@"status"];
    }
    if (wares) {
        [dic setObject:wares forKey:@"wares"];
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

//删除盘点单中的单个商品
+ (void)deleteInventroyWareWithInventroyId:(NSNumber *)inventoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_DeleteInventoryWare,inventoryId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              success(responseObject);
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

@end
