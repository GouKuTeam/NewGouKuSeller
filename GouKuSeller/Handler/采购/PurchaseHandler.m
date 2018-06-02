//
//  PurchaseHandler.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "PurchaseHandler.h"
#import "CategoryEntity.h"
#import "StoreEntity.h"
#import "SupplierCommodityEndity.h"
#import "AddressEntity.h"

@implementation PurchaseHandler

//所有类目
+ (void)getAllCategoryWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_ALLCATEGORY];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_date = [CategoryEntity parseCategoryListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_date);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//类目搜索供应商
+ (void)getCategorySupplierWithCategoryId:(NSNumber *)categoryId page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_SUPPLIERWITHCATEGORY];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInt:page],@"industryId":categoryId};
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_date = [StoreEntity parseStoreListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_date);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//通过名字搜索供应商
+ (void)searchSupplierWithName:(NSString *)name page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_SearchSupplier];
    NSDictionary *dic = @{@"name":name,@"page":[NSNumber numberWithInt:page]
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_date = [StoreEntity parseStoreListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_date);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//查询所有商品
+ (void)getWareWithShopId:(NSNumber *)shopId keyword:(NSString *)keyword status:(NSNumber *)status firstCategoryId:(NSNumber *)firstCategoryId page:(NSInteger)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_WARE];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (shopId) {
        [dic setObject:shopId forKey:@"shopId"];
    }
    if (keyword.length > 0) {
        [dic setObject:keyword forKey:@"keyword"];
    }
    if (status) {
        [dic setObject:status forKey:@"status"];
    }
    if (firstCategoryId) {
        [dic setObject:firstCategoryId forKey:@"firstCategoryId"];
    }
    [dic setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_date = [SupplierCommodityEndity parseSupplierCommodityEndityListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_date);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//关注供应商
+ (void)addSupplierAttentionWithSid:(NSNumber *)sid name:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_SupplierAttentionAdd];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (sid) {
        [dic setObject:sid forKey:@"sid"];
    }
    if (name) {
        [dic setObject:name forKey:@"name"];
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

//取消关注(供应商）
+ (void)cancelSupplierAttentionWithSid:(NSNumber *)sid name:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_SupplierAttentionCancel];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (sid) {
        [dic setObject:sid forKey:@"sid"];
    }
    if (name) {
        [dic setObject:name forKey:@"name"];
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

//添加商品至购物车
+ (void)addCommodityToShoppingCarWithSkuId:(NSNumber *)skuId skuUnitId:(NSNumber *)skuUnitId count:(NSNumber *)count prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_AddShoppingCar];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (skuId) {
        [dic setObject:skuId forKey:@"skuId"];
    }
    if (skuUnitId) {
        [dic setObject:skuUnitId forKey:@"skuUnitId"];
    }
    if (count) {
        [dic setObject:count forKey:@"count"];
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
                                              [MBProgressHUD hideHUD];
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}
//查看所有地址
+ (void)selectAllAddressWithprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_SelectAddressList];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  NSArray *arr_date = [AddressEntity parseAddressEntityListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_date);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
    
}
//添加新地址
+ (void)addNewAddressWithName:(NSString *)name phone:(NSString *)phone provinceId:(int)provinceId cityId:(int)cityId districtId:(int)districtId provinceName:(NSString *)provinceName cityName:(NSString *)cityName districtName:(NSString *)districtName address:(NSString *)address lat:(NSString *)lat lon:(NSString *)lon houseNum:(NSString *)houseNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_AddNewAddress];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (name) {
        [dic setObject:name forKey:@"name"];
    }
    if (phone) {
        [dic setObject:phone forKey:@"phone"];
    }
    if (provinceId) {
        [dic setObject:[NSNumber numberWithInt:provinceId] forKey:@"provinceId"];
    }
    if (cityId) {
        [dic setObject:[NSNumber numberWithInt:cityId] forKey:@"cityId"];
    }
    if (districtId) {
        [dic setObject:[NSNumber numberWithInt:districtId] forKey:@"districtId"];
    }
    if (provinceName) {
        [dic setObject:provinceName forKey:@"provinceName"];
    }
    if (cityName) {
        [dic setObject:cityName forKey:@"cityName"];
    }
    if (districtName) {
        [dic setObject:districtName forKey:@"districtName"];
    }
    if (address) {
        [dic setObject:address forKey:@"address"];
    }
    if (lat) {
        [dic setObject:lat forKey:@"lat"];
    }
    if (lon) {
        [dic setObject:lon forKey:@"lon"];
    }
    if (houseNum) {
        [dic setObject:houseNum forKey:@"houseNum"];
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

//编辑地址
+ (void)updateAddressWithAddressId:(NSNumber *)addressId name:(NSString *)name phone:(NSString *)phone provinceId:(int)provinceId cityId:(int)cityId districtId:(int)districtId provinceName:(NSString *)provinceName cityName:(NSString *)cityName districtName:(NSString *)districtName address:(NSString *)address lat:(NSString *)lat lon:(NSString *)lon houseNum:(NSString *)houseNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_UpdateAddress];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (addressId) {
        [dic setObject:addressId forKey:@"id"];
    }
    if (name) {
        [dic setObject:name forKey:@"name"];
    }
    if (phone) {
        [dic setObject:phone forKey:@"phone"];
    }
    if (provinceId) {
        [dic setObject:[NSNumber numberWithInt:provinceId] forKey:@"provinceId"];
    }
    if (cityId) {
        [dic setObject:[NSNumber numberWithInt:cityId] forKey:@"cityId"];
    }
    if (districtId) {
        [dic setObject:[NSNumber numberWithInt:districtId] forKey:@"districtId"];
    }
    if (provinceName) {
        [dic setObject:provinceName forKey:@"provinceName"];
    }
    if (cityName) {
        [dic setObject:cityName forKey:@"cityName"];
    }
    if (districtName) {
        [dic setObject:districtName forKey:@"districtName"];
    }
    if (address) {
        [dic setObject:address forKey:@"address"];
    }
    if (lat) {
        [dic setObject:lat forKey:@"lat"];
    }
    if (lon) {
        [dic setObject:lon forKey:@"lon"];
    }
    if (houseNum) {
        [dic setObject:houseNum forKey:@"houseNum"];
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

//设置默认地址
+ (void)setDefaultAddressWithAddressId:(NSNumber *)addressId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@/%@",API_Other,API_GET_SettingDefaultAddress,addressId];
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

//获取默认地址
+ (void)selectDefaultAddressWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_SelectDefaultAddress];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              success(responseObject);
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//删除地址
+ (void)deleteAddressWithAddressId:(NSNumber *)addressId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@/%@",API_Other,API_GET_DeleteAddress,addressId];
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

//查询供应商详情
+ (void)selectSupplierDetailWithShopId:(NSNumber *)shopid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_SelectSupplierDetail];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (shopid) {
        [dic setObject:shopid forKey:@"shopId"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  StoreEntity *entity = [StoreEntity parseStoreEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//获取省市区
+ (void)getProvinceCityAreaprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_SSQ];
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
