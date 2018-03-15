//
//  CommodityHandler.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CommodityHandler.h"
#import "ShopClassificationEntity.h"
#import "CommodityInformationEntity.h"
#import "CommodityCatagoryEntity.h"
#import "StandardEntity.h"
@implementation CommodityHandler

// 获取店内分类列表数据
+ (void)getCommodityCategoryWithShopId:(NSString *)shopId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed
{
//    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_ShopCommodityCategory,shopId]];
    NSString *str_url = @"http://47.97.174.40:9001/shop/ware/category/all/1";
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_data = [ShopClassificationEntity parseShopClassificationListWithJson:[responseObject objectForKey:@"data"]];
                                                  
                                                  success(arr_data);
                                                  
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}
//获取分类下店内商品列表
+ (void)getComdityInformationWithShopId:(long)shopId shopWareCategoryId:(int)shopWareCategoryId status:(int)status prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [self requestUrlWithPath:API_GET_CommodityInformation];
    
    NSDictionary *dic = @{@"shopId":[NSNumber numberWithLong:shopId],
                          @"shopWareCategoryId":[NSNumber numberWithInt:shopWareCategoryId],
                          @"status":[NSNumber numberWithInt:status]
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_data = [CommodityInformationEntity parseCommodityInformationListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_data);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//获取商品分类列表
+ (void)getCommodityWithPid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_CommodityCatahory,[NSNumber numberWithInt:pid]]];
    
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_data = [CommodityCatagoryEntity parseCommodityCatagoryListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_data);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//获取商品规格
+ (void)getStandardWithCategoryId:(int)categoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_Standard,[NSNumber numberWithInt:categoryId]]];
//    NSString *str_url = @"http://47.97.174.40:9001/ware/standard/list/3";
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_data = [StandardEntity parseStandardListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_data);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}










@end
