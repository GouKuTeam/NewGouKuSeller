//
//  InventoryHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/14.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface InventoryHandler : BaseHandler
//根据条形码获取商品详情
+ (void)selectInventoryWareInventoryInformationWithBarcode:(NSString *)barcode prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//查询盘点记录列表
+ (void)inventroyListWithPage:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
