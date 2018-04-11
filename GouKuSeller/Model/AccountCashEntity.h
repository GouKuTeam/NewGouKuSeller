//
//  AccountCashEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"
#import "BankCardEntity.h"

@interface AccountCashEntity : BaseEntity

@property (nonatomic ,assign)double            money;
@property (nonatomic ,assign)double            moneyNeedCheck;
@property (nonatomic ,assign)int               toCashNum;
@property (nonatomic ,assign)double            lowMoney;
@property (nonatomic ,strong)BankCardEntity    *bankCard;

+ (NSArray *)parseStandardListWithJson:(id)json;
+ (AccountCashEntity *)parseStandardEntityWithJson:(id)json;

@end

/*
"money":<double>                    //账户余额
"moneyNeedCheck":<double>           //待结算金额
"toCashNum"<int>                    //提现次数
"lowMoney"<double>                  //最低提现金额
"cards":<BankCard>                  //银行卡信息  为null时没有绑定
 */
