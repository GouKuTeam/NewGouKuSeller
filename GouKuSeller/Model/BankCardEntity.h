//
//  BankCardEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/8.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface BankCardEntity : BaseEntity

@property (nonatomic ,strong)NSNumber             *shopId;
@property (nonatomic ,strong)NSNumber             *cardNum;
@property (nonatomic ,strong)NSString             *bankName;
@property (nonatomic ,strong)NSString             *place;
@property (nonatomic ,strong)NSString             *bankBranch;
@property (nonatomic ,strong)NSString             *accountName;
@property (nonatomic ,assign)BOOL                  cardType;


+ (NSArray *)parseWareCategoryWithJson:(id)json;
+ (BankCardEntity *)parseWareCategoryEntityWithJson:(id)json;
@end

/*
"shopId":<long>                     //门店ID
"cardNum":<long>                    //银行卡号
"bankName":<String>                 //开户银行
"palce":<String>                    //地区
"bankBranch":<String>               //开户支行
"cardType":<>                       //类型 false 个人 true 公司
*/
