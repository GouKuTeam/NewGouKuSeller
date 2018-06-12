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

//获取供应商订单个数
+(void)getSupplierOrderCountPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//设置供应商运费和起送费
+ (void)setSupplierPriceWithDispatchingPrice:(NSString *)dispatchingPrice takeOffPrice:(NSString *)takeOffPrice prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取供应商运费和起送费
+ (void)getSupplierPriceWithDispatchingPrice:(NSString *)dispatchingPrice takeOffPrice:(NSString *)takeOffPrice prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

/*
 外部订单(美团、饿了么) API
 */
//商户查询待处理订单
+ (void)shopSelectManagerOrderWithOrderStatus:(NSNumber *)orderStatus prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//商户接单
+ (void)shopGetOrderWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//商户同意用户取消订单
+ (void)shopAgreeUserCancelOrderWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//商户查询订单
+ (void)shopSelectOrderWithOrderStatus:(NSNumber *)orderStatus keyWords:(NSString *)keyWords pageNum:(int)pageNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查询待处理订单数量
+ (void)selectOutOrderCountPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取订单详情
+ (void)shopGetOutOrderDetailWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;


@end
