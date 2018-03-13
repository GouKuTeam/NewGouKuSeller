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
@end
