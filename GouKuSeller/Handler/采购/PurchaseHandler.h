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
+ (void)searchSupplierWithName:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查询所有商品
+ (void)getWareWithShopId:(NSNumber *)shopId keyword:(NSString *)keyword status:(NSNumber *)status firstCategoryId:(NSNumber *)firstCategoryId page:(NSInteger)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//关注供应商
+ (void)addSupplierAttentionWithSid:(NSNumber *)sid name:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//取消关注(供应商）
+ (void)cancelSupplierAttentionWithSid:(NSNumber *)sid name:(NSString *)name prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
