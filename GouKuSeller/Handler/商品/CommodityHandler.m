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
#import "CommodityFromCodeEntity.h"
#import "SupplierCommodityEndity.h"
@implementation CommodityHandler

// 获取店内分类列表数据
+ (void)getCommodityCategoryWithShopId:(NSString *)shopId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_ShopCommodityCategory,shopId];
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

//获取店内一级分类
+ (void)getShopCatagoryWithShopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_GET_ShopCatagory];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_ShopCatagory];
    NSDictionary *dic = @{@"shopId":shopId,@"pid":[NSNumber numberWithInt:pid]};
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
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

//获取商品规格
+ (void)getStandardWithCategoryId:(int)categoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_Standard,[NSNumber numberWithInt:categoryId]]];
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_Standard,[NSNumber numberWithInt:categoryId]];
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

+ (void)getCommodityInformationWithBarCode:(NSString *)barcode prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
//    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_CommodityInformationFromBarCode,barcode]];
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_CommodityInformationFromBarCode,barcode];
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


//新增店内分类
+ (void)addShopCatagoryWithName:(NSString *)name shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_GET_AddShopCatagory];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_AddShopCatagory];
    NSDictionary *dic = @{@"name":name,
                          @"shopId":shopId,
                          @"pid":[NSNumber numberWithInt:pid]
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  [MBProgressHUD showSuccessMessage:@"添加分类成功"];
                                                   success(nil);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
    
}

//修改店内分类
+ (void)udpShopCatagoryWithName:(NSString *)name ownid:(int)ownid shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_GET_UdpShopCatagory];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_UdpShopCatagory];
    NSDictionary *dic = @{@"name":name,
                          @"id":[NSNumber numberWithInt:ownid],
                          @"shopId":shopId,
                          @"pid":[NSNumber numberWithInt:pid]
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  [MBProgressHUD showSuccessMessage:@"修改分类成功"];
                                                  success(nil);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)delShopCatagoryWithOwnId:(int)ownid shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_GET_DelShopCatagory];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_DelShopCatagory];
    NSDictionary *dic = @{
                          @"id":[NSNumber numberWithInt:ownid],
                          @"shopId":shopId,
                          @"pid":[NSNumber numberWithInt:pid]
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
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

//新增商品
+ (void)addCommodityWithShopId:(NSNumber *)shopId name:(NSString *)name itemId:(NSNumber *)itemId barcode:(NSNumber *)barcode shopWareCategoryId:(NSNumber *)shopWareCategoryId wareCategoryId:(NSNumber *)wareCategoryId price:(double)price stock:(NSNumber *)stock pictures:(NSString *)pictures standards:(NSString *)standards wid:(NSNumber *)wid xprice:(double)xprice prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
//    NSString *str_url = [self requestUrlWithPath:API_GET_AddCommodity];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_AddCommodity];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (shopId) {
        [dic setObject:shopId forKey:@"shopId"];
    }
    if (name) {
        [dic setObject:name forKey:@"name"];
    }
    if (itemId) {
        [dic setObject:itemId forKey:@"itemId"];
    }
    if (barcode) {
        [dic setObject:barcode forKey:@"barcode"];
    }
    if (shopWareCategoryId) {
        [dic setObject:shopWareCategoryId forKey:@"shopWareCategoryId"];
    }
    if (price) {
        [dic setObject:[NSNumber numberWithDouble:price] forKey:@"price"];
    }
    if (xprice) {
        [dic setObject:[NSNumber numberWithDouble:xprice] forKey:@"xprice"];
    }
    if (stock) {
        [dic setObject:stock forKey:@"stock"];
    }
    if (pictures) {
        [dic setObject:pictures forKey:@"pictures"];
    }
    if (standards) {
        [dic setObject:standards forKey:@"standards"];
    }
    if (wid) {
        [dic setObject:wid forKey:@"wid"];
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

//商品列表查询
+ (void)getCommodityListWithshopId:(NSNumber *)shopId shopWareCategoryId:(NSNumber *)shopWareCategoryId status:(NSNumber *)status pageNum:(int)pageNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_GET_CommodityList];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_CommodityList];
    NSDictionary *dic = @{
                          @"shopId":shopId,
                          @"shopWareCategoryId":shopWareCategoryId,
                          @"status":status,
                          @"page":[NSNumber numberWithInt:pageNum]
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  NSArray *arr_data = [CommodityFromCodeEntity parseCommodityFromCodeListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_data);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
    
}

//搜索商品
+ (void)searchCommodityWithShopId:(NSNumber *)shopId keyword:(NSString *)keyword pageNum:(int)pageNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_GET_SearchCommodity];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_SearchCommodity];

    NSDictionary *dic = @{
                          @"shopId":shopId,
                          @"keyword":keyword,
                          @"page":[NSNumber numberWithInt:pageNum]
                        };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  
                                                  NSArray *arr = [CommodityFromCodeEntity parseCommodityFromCodeListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//门店商品下架
+ (void)commoditydownShelfWithCommodityId:(NSString *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_downshelf,commodityId]];
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_downshelf,commodityId];
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

//门店商品上架
+ (void)commodityupShelfWithCommodityId:(NSString *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_upshelf,commodityId]];
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_upshelf,commodityId];
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

//门店商品删除
+ (void)commoditydeleteWithCommodityId:(NSString *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:[NSString stringWithFormat:API_GET_CommodityDelete,commodityId]];
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_GET_CommodityDelete,commodityId];
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

//门店商品编辑(更新)
+ (void)commodityEditWithCommodityId:(NSString *)commodityId price:(double)price stock:(NSString *)stock xprice:(double)xprice shopWareCategoryId:(NSNumber *)shopWareCategoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
//    NSString *str_url = [self requestUrlWithPath:API_GET_CommodityEdit];
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_GET_CommodityEdit];
    NSDictionary *dic = @{
                          @"skuId":commodityId,
                          @"price":[NSNumber numberWithDouble:price],
                          @"stock":stock,
                          @"xprice":[NSNumber numberWithDouble:xprice],
                          @"shopWareCategoryId":shopWareCategoryId
                          };
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0) {
                                                  
                                                  CommodityFromCodeEntity *entity = [CommodityFromCodeEntity parseCommodityFromCodeEntityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//供应商新建商品
+ (void)addSupplierCommodityWithWareItemId:(NSNumber *)wareItemId firstCategoryId:(NSNumber *)firstCategoryId stock:(int)stock xprice:(NSString *)xprice musing:(NSString *)musing price:(NSString *)price saleUnits:(NSArray *)saleUnits prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_AddSupplierCommdity];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (wareItemId) {
        [dic setObject:wareItemId forKey:@"wareItemId"];
    }
    if (firstCategoryId) {
        [dic setObject:firstCategoryId forKey:@"firstCategoryId"];
    }
    if (stock) {
        [dic setObject:[NSNumber numberWithInt:stock] forKey:@"stock"];
    }
    if (xprice) {
        [dic setObject:xprice forKey:@"xprice"];
    }
    if (musing) {
        [dic setObject:musing forKey:@"using"];
    }
    if (price) {
        [dic setObject:price forKey:@"price"];
    }
    if (saleUnits) {
        [dic setObject:saleUnits forKey:@"saleUnits"];
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

//供应商商品列表查询
+ (void)selectSupplierCommodityListWithKeyword:(NSString *)keyword status:(NSNumber *)status firstCategoryId:(NSNumber *)firstCategoryId page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_SupplierCommodityList];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (keyword) {
        [dic setObject:keyword forKey:@"keyword"];
    }
    if (firstCategoryId) {
        [dic setObject:firstCategoryId forKey:@"firstCategoryId"];
    }
    if (status) {
        [dic setObject:status forKey:@"status"];
    }
    if (page) {
        [dic setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    }
    
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  NSArray *arr_data = [SupplierCommodityEndity parseSupplierCommodityEndityListWithJson:[responseObject objectForKey:@"data"]];
                                                  success(arr_data);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
   
}

//供应商修改商品状态
+ (void)updateSupplierCommodityStatusWithCommodityId:(NSNumber *)commodityId type:(NSNumber *)type prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_UpdateSupplierCommodityStatus];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (commodityId) {
        [dic setObject:commodityId forKey:@"skuId"];
    }
    if (type) {
        [dic setObject:type forKey:@"type"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
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

//供应商商品删除
+ (void)deleteSupplierCommodityWithCommodityId:(NSNumber *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_POST_SupplierCommodityDelete,commodityId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
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

//获取商品详情
+ (void)getSupplierCommodityInformationWithSkuId:(NSNumber *)skuId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    NSString *str_url = [NSString stringWithFormat:@"%@%@%@",API_Other,API_POST_GETSupplierCommodityInformation,skuId];
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestGet
                                       parameters:nil
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  SupplierCommodityEndity *entity = [SupplierCommodityEndity parseSupplierCommodityEndityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

//供应商商品修改
+ (void)updateSupplierCommodityWithSkuId:(NSNumber *)skuId wareItemId:(NSNumber *)wareItemId firstCategoryId:(NSNumber *)firstCategoryId stock:(int)stock xprice:(NSString *)xprice musing:(BOOL)musing price:(NSString *)price saleUnits:(NSArray *)saleUnits deleteUnitIds:(NSArray *)deleteUnitIds hitType:(int)hitType prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSString *str_url = [NSString stringWithFormat:@"%@%@",API_Other,API_POST_UpdateSupplierCommodity];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (skuId) {
        [dic setObject:skuId forKey:@"skuId"];
    }
    if (wareItemId) {
        [dic setObject:wareItemId forKey:@"wareItemId"];
    }
    if (firstCategoryId) {
        [dic setObject:firstCategoryId forKey:@"firstCategoryId"];
    }
    if (stock) {
        [dic setObject:[NSNumber numberWithInt:stock] forKey:@"stock"];
    }
    if (xprice) {
        [dic setObject:[NSString stringWithFormat:@"%.2f",[xprice doubleValue]] forKey:@"xprice"];
    }
    if (musing) {
        [dic setObject:[NSNumber numberWithBool:musing] forKey:@"using"];
    }
    if (price) {
        [dic setObject:price forKey:@"price"];
    }
    if (saleUnits) {
        [dic setObject:saleUnits forKey:@"saleUnits"];
    }
    if (deleteUnitIds.count > 0) {
        [dic setObject:deleteUnitIds forKey:@"deleteUnitIds"];
    }
    if (hitType) {
        [dic setObject:[NSNumber numberWithInt:hitType] forKey:@"hitType"];
    }
    [[RTHttpClient defaultClient] requestWithPath:str_url
                                           method:RTHttpRequestPost
                                       parameters:dic
                                          prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if ([[responseObject objectForKey:@"errCode"] intValue] == 0 ) {
                                                  SupplierCommodityEndity *entity = [SupplierCommodityEndity parseSupplierCommodityEndityWithJson:[responseObject objectForKey:@"data"]];
                                                  success(entity);
                                              }else{
                                                  [MBProgressHUD hideHUD];
                                                  [MBProgressHUD showErrorMessage:[responseObject objectForKey:@"errMessage"]];
                                              }
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

@end
