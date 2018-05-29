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
//盘点记录新增
+ (void)addInventoryWithTitle:(NSString *)title status:(NSNumber *)status wares:(NSArray *)wares prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//删除一条盘点记录
+ (void)deleteInventroyWithInventroyId:(NSNumber *)inventoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//查询一条盘点记录
+ (void)selectInventroyDetailWithInventroyId:(NSNumber *)inventoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//盘点记录修改
+ (void)updateInventoryWithInventoryId:(NSNumber *)inventoryId Title:(NSString *)title status:(NSNumber *)status wares:(NSArray *)wares prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//删除盘点单中的单个商品
+ (void)deleteInventroyWareWithInventroyId:(NSNumber *)inventoryId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
