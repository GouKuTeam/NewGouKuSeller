//
//  AccountCashDetailEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"
#import "BankCardEntity.h"

@interface AccountCashDetailEntity : BaseEntity

@property (nonatomic ,assign)int             accountType;   //1.销售结算  2.提现
@property (nonatomic ,assign)double          accountNum;    //金额
@property (nonatomic ,strong)NSString        *date;
@property (nonatomic ,strong)NSString        *accountName;

@property (nonatomic ,strong)NSNumber        *cashOrderId;
@property (nonatomic ,assign)double           applyTime;
@property (nonatomic ,assign)double           arriveTime;
@property (nonatomic ,assign)int             accountCashType;  //提现状态 1 待打款 2 已打款
@property (nonatomic ,assign)double          money;
@property (nonatomic ,strong)BankCardEntity    *bankCard;

+ (NSArray *)parseStandardListWithJson:(id)json;
+ (AccountCashDetailEntity *)parseStandardEntityWithJson:(id)json;

@end


/*
 "cashOrderId":<long>                //提现订单编号
 "applyTime":<Date>                  //申请时间
 "arriveTime":<Date>                 //到达时间
 "accountCashType":<int>             //提现状态 1 待打款 2 已打款
 "money":<double>                    //提现金额
 "banckCard":<BankCard对象>          //银行卡信息
 */
