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

@end
