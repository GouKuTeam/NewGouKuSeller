//
//  MyHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface MyHandler : BaseHandler

+ (void)mineShopListWithAccount:(NSString *)account prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
//工作台当日数据
+ (void)getTodayMsgprepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//app版本号(是否需要强制更新)
+ (void)getAppVersionPrepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//设置是否自动打印
+ (void)setAutoPrintWithAuto:(int)autoNum Prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//设置打印联数
+ (void)setPrintNumWithPrinterNum:(int)printerNum Prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
