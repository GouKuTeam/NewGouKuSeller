//
//  CashierHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/10.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface CashierHandler : BaseHandler

//扫描商品条形码加入购物车  (dic 包含barcode  shopId   addup(合计金额))
+(void)commodityCashierWithBarcode:(NSString *)barcode shopId:(NSNumber *)shopid addup:(NSString *)addup prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//添加订单
+(void)addOrderWithShopId:(NSNumber *)shopid items:(NSArray *)items payTotal:(NSString *)payTotal payReduce:(NSString *)payReduce payActual:(NSString *)payActual noGoods:(NSString *)noGoods payType:(int)payType orderDiscount:(NSString *)orderDiscount orderMinus:(NSString *)orderMinus loseSmallReduce:(NSString *)loseSmallReduce actId:(NSNumber *)actId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//扫描用户付款码
+(void)scanUserCashCodeWithOpenId:(NSString *)openid orderId:(NSString *)orderid prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//查询满减金额
+(void)selectManJianPriceWithaddup:(NSString *)addup prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//现金收银
+(void)payInCashWithOrderId:(NSString *)orderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
