//
//  SettlementHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface SettlementHandler : BaseHandler
//结算首页信息
+(void)accountshowWithshopId:(NSNumber *)shopId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//余额明细
+(void)accountdetailsWithshopId:(NSNumber *)shopId page:(int)page type:(int)type prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//获取银行卡列表
+(void)getbankListprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//获取验证码
+(void)getAccountCodeWithphoneNum:(NSString *)phoneNum prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//添加银行卡
+(void)addBankCardWithBankDic:(NSDictionary *)dic prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//提现校验密码
+(void)checkPassWordWithshopId:(NSNumber *)shopId cardNum:(NSString *)cardNum money:(double)money username:(NSString *)username password:(NSString *)password prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//提现详情
+(void)cashDetailWithShopId:(NSNumber *)shopid cashOrderId:(NSString *)cashOrderId prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//微信充值
+(void)weixinchongzhiWithPrice:(NSString *)price prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
