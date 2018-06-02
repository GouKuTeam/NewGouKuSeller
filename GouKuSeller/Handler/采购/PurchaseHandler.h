//
//  PurchaseHandler.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface PurchaseHandler : BaseHandler

//所有类目
+ (void)getAllCategoryWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//类目搜索供应商
+ (void)getCategorySupplierWithCategoryId:(NSNumber *)categoryId page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//通过名字搜索供应商
+ (void)searchSupplierWithName:(NSString *)name page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查询所有商品
+ (void)getWareWithShopId:(NSNumber *)shopId keyword:(NSString *)keyword status:(NSNumber *)status firstCategoryId:(NSNumber *)firstCategoryId page:(NSInteger)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//关注供应商
+ (void)addSupplierAttentionWithSid:(NSNumber *)sid name:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//取消关注(供应商）
+ (void)cancelSupplierAttentionWithSid:(NSNumber *)sid name:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//添加商品至购物车   (添加一个  count + 1    删除一个  count - 1)
+ (void)addCommodityToShoppingCarWithSkuId:(NSNumber *)skuId skuUnitId:(NSNumber *)skuUnitId count:(NSNumber *)count prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查看所有地址
+ (void)selectAllAddressWithprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//添加新的地址
+ (void)addNewAddressWithName:(NSString *)name phone:(NSString *)phone provinceId:(int)provinceId cityId:(int)cityId districtId:(int)districtId provinceName:(NSString *)provinceName cityName:(NSString *)cityName districtName:(NSString *)districtName address:(NSString *)address lat:(NSString *)lat lon:(NSString *)lon houseNum:(NSString *)houseNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//编辑地址
+ (void)updateAddressWithAddressId:(NSNumber *)addressId name:(NSString *)name phone:(NSString *)phone provinceId:(int)provinceId cityId:(int)cityId districtId:(int)districtId provinceName:(NSString *)provinceName cityName:(NSString *)cityName districtName:(NSString *)districtName address:(NSString *)address lat:(NSString *)lat lon:(NSString *)lon houseNum:(NSString *)houseNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//设置默认地址
+ (void)setDefaultAddressWithAddressId:(NSNumber *)addressId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取默认地址
+ (void)selectDefaultAddressWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//删除地址
+ (void)deleteAddressWithAddressId:(NSNumber *)addressId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查询供应商详情
+ (void)selectSupplierDetailWithShopId:(NSNumber *)shopid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取省市区
+ (void)getProvinceCityAreaprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
