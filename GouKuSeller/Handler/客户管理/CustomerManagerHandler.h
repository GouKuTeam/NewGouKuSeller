//
//  CustomerManagerHandler.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseHandler.h"

@interface CustomerManagerHandler : BaseHandler

//获取客户列表
+ (void)getCustomerListWithPage:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

//搜索客户
+ (void)searchCustomerListWithName:(NSString *)name page:(int)page prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;

@end
