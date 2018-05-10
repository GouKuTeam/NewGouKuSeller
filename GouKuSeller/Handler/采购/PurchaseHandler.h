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

@end
