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
+ (void)getCommodityListWithtype:(NSNumber *)type firstCategoryId:(NSNumber *)firstCategoryId status:(NSNumber *)status keyword:(NSString *)keyword pageNum:(int)pageNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//搜索商品
+ (void)searchCommodityWithShopId:(NSNumber *)shopId keyword:(NSString *)keyword pageNum:(int)pageNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//商品库单个商品删除
+ (void)commoditydeleteWithCommodityId:(NSString *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//商品库商品编辑(更新)
+ (void)commodityEditWithSkuId:(NSNumber *)skuId name:(NSString *)name wareBarcode:(NSNumber *)wareBarcode pictures:(NSString *)pictures stock:(NSString *)stock description:(NSString *)description xprice:(NSString *)xprice firstCategoryId:(NSNumber *)firstCategoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//门店自定义商品
+ (void)addCustomizeCommodityWithShopId:(NSNumber *)shopId name:(NSString *)name barcode:(NSString *)barcode description:(NSString *)description shopWareCategoryId:(NSNumber *)shopWareCategoryId xprice:(NSString *)xprice stock:(NSNumber *)stock pictures:(NSString *)pictures prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//v1.4 新增自定义商品
+ (void)addCustomizeCommodityWithCommodityId:(NSNumber *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//商品发布  "releaseType"  //发布类型(必填1:门店商品,2:网店商品)
+ (void)commodityReleaseWithSkuId:(NSNumber *)skuId name:(NSString *)name firstCategoryId:(NSNumber *)firstCategoryId description:(NSString *)description stock:(NSNumber *)stock price:(NSString *)price releaseType:(int)releaseType prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//商品批量发布
+ (void)commodityReleaseListWithCommodityArr:(NSMutableArray *)commodityArr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//商品批量删除
+ (void)commodityDeleteListWithCommodityArr:(NSMutableArray *)commodityArr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//门店 ，网店商品修改
+ (void)wareSkuUpdateWithSkuId:(NSNumber *)skuId name:(NSString *)name firstCategoryId:(NSNumber *)firstCategoryId description:(NSString *)description stock:(NSNumber *)stock price:(NSString *)price releaseType:(int)releaseType prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//门店 网店商品  单个 上下架
+ (void)wareSkuUpdateStatusWithSkuId:(NSNumber *)skuId releaseType:(int)releaseType status:(NSNumber *)status prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//门店，网店 商品  单个移除
+ (void)wareSkuRemoveWareWithSkuId:(NSNumber *)skuId releaseType:(int)releaseType prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//门店。网店  批量 商品上、下架
+ (void)wareSkuUpdateStatusListWithCommodityArr:(NSMutableArray *)commodityArr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//门店，网店 商品  批量 移除
+ (void)wareSkuRemoveWareListWithCommodityArr:(NSMutableArray *)commodityArr prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;








//供应商新建商品
+ (void)addSupplierCommodityWithWareItemId:(NSNumber *)wareItemId firstCategoryId:(NSNumber *)firstCategoryId stock:(int )stock xprice:(NSString *)xprice musing:(NSString *)musing price:(NSString *)price saleUnits:(NSArray *)saleUnits prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//供应商商品列表查询(后台管理)
+ (void)selectSupplierCommodityListWithKeyword:(NSString *)keyword status:(NSNumber *)status firstCategoryId:(NSNumber *)firstCategoryId page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//供应商修改商品状态
+ (void)updateSupplierCommodityStatusWithCommodityId:(NSNumber *)commodityId type:(NSNumber *)type prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//供应商商品删除
+ (void)deleteSupplierCommodityWithCommodityId:(NSNumber *)commodityId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//获取商品详情
+ (void)getSupplierCommodityInformationWithSkuId:(NSNumber *)skuId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//供应商商品修改
+ (void)updateSupplierCommodityWithSkuId:(NSNumber *)skuId wareItemId:(NSNumber *)wareItemId firstCategoryId:(NSNumber *)firstCategoryId stock:(int)stock xprice:(NSString *)xprice musing:(BOOL)musing price:(NSString *)price saleUnits:(NSArray *)saleUnits deleteUnitIds:(NSArray *)deleteUnitIds hitType:(int)hitType prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//上传图片
+ (void)uploadPicWithPicData:(NSData *)picData prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
