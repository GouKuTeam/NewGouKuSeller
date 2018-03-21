//
//  CommodityHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface CommodityHandler : BaseHandler
//获取门店商品类目列表
+ (void)getCommodityCategoryWithShopId:(NSString *)shopId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取类目对应商品列表
+ (void)getComdityInformationWithShopId:(long)shopId shopWareCategoryId:(int)shopWareCategoryId status:(int)status prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取商品分类列表
+ (void)getCommodityWithPid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取店内一级分类
+ (void)getShopCatagoryWithShopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取商品规格值 
+ (void)getStandardWithCategoryId:(int)categoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//通过条形码获取商品信息
+ (void)getCommodityInformationWithBarCode:(int)barcode prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//新增店内分类
+ (void)addShopCatagoryWithName:(NSString *)name shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//修改店内分类
+ (void)udpShopCatagoryWithName:(NSString *)name ownid:(int)ownid shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//删除店内分类
+ (void)delShopCatagoryWithOwnId:(int)ownid shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
