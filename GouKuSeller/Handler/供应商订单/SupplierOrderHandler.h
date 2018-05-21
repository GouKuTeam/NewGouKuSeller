//
//  SupplierOrderHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/21.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface SupplierOrderHandler : BaseHandler
//根据状态或关键词查询供应商订单列表
+ (void)supplierOrderListWithStatus:(NSNumber *)status keyWord:(NSString *)keyWord prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//供应商修改订单价格
+ (void)supplierChangeOrderPriceWithOrderId:(NSNumber *)orderId price:(NSString *)price prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//供应商取消订单
+(void)supplierCancelOrderWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//供应商发货
+(void)supplierSendCommodityWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
