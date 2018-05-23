//
//  ShoppingHandler.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface ShoppingHandler : BaseHandler

//获取购物车列表
+ (void)getShoppingListWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//清空购物车
+ (void)clearShoppingCarWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//删除一个购物车商品
+ (void)deleteShopSingleCommodityWithSkuId:(NSNumber *)skuId skuUnitId:(NSNumber *)skuUnitId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//删除一个购物车商品
+ (void)deleteShopMoreCommodityWithCommodityArray:(NSArray *)commodityArray prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//清空购物车失效商品
+ (void)shoppingRemoveWithPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//结算生成新订单
+ (void)generateNewOrderWithReceiver:(NSString *)receiver address:(NSString *)address phone:(NSString *)phone items:(NSArray *)items remarks:(NSArray *)remarks prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查询采购订单列表
+ (void)selectOrderListWithStatus:(NSNumber *)status keyWord:(NSString *)keyWord page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//采购订单详情
+ (void)selectShopOrderDetailWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//取消采购订单
+ (void)cancelShopOrderDetailWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//采购订单确认收货
+ (void)confirmShopOrderDetailWithOrderId:(NSNumber *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取购物车中商品个数
+ (void)getCountInShopCartprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//用户支付订单
+ (void)payOrderWithOrderId:(NSString *)orderId passWord:(NSString *)password prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//用户支付多个订单
+ (void)payMoreOrderWithOrderId:(NSArray *)orderId passWord:(NSString *)password prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
