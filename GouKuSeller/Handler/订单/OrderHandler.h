//
//  OrderHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface OrderHandler : BaseHandler

//获取订单列表
+ (void)getOrderListWithShopId:(NSNumber *)shopId page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//订单详情查询
+ (void)getOrderDetailsWithShopId:(NSNumber *)shopid orderId:(NSString *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//订单搜索
+ (void)searchOrderWithShopId:(NSNumber *)shopid orderId:(NSString *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
