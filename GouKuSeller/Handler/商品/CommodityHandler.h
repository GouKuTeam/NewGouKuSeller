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

//获取商品分类列表
+ (void)getCommodityWithPid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取店内一级分类
+ (void)getShopCatagoryWithShopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取商品规格值 
+ (void)getStandardWithCategoryId:(int)categoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//通过条形码获取商品信息
+ (void)getCommodityInformationWithBarCode:(NSString *)barcode prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//新增店内分类
+ (void)addShopCatagoryWithName:(NSString *)name shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//修改店内分类
+ (void)udpShopCatagoryWithName:(NSString *)name ownid:(int)ownid shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//删除店内分类
+ (void)delShopCatagoryWithOwnId:(int)ownid shopId:(NSNumber *)shopId pid:(int)pid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//新增商品
+ (void)addCommodityWithShopId:(NSNumber *)shopId name:(NSString *)name itemId:(NSNumber *)itemId barcode:(NSNumber *)barcode shopWareCategoryId:(NSNumber *)shopWareCategoryId wareCategoryId:(NSNumber *)wareCategoryId price:(double)price stock:(NSNumber *)stock pictures:(NSString *)pictures standards:(NSString *)standards wid:(NSNumber *)wid xprice:(double)xprice prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//商品列表查询
+ (void)getCommodityListWithshopId:(NSNumber *)shopId shopWareCategoryId:(NSNumber *)shopWareCategoryId status:(NSNumber *)status pageNum:(int)pageNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//搜索商品
+ (void)searchCommodityWithShopId:(NSNumber *)shopId keyword:(NSString *)keyword pageNum:(int)pageNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//门店商品下架
+ (void)commoditydownShelfWithCommodityId:(NSString *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//门店商品上架
+ (void)commodityupShelfWithCommodityId:(NSString *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//门店商品删除
+ (void)commoditydeleteWithCommodityId:(NSString *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//门店商品编辑(更新)
+ (void)commodityEditWithCommodityId:(NSNumber *)commodityId price:(double)price stock:(NSString *)stock xprice:(double)xprice shopWareCategoryId:(NSNumber *)shopWareCategoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
