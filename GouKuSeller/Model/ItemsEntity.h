//
//  ItemsEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface ItemsEntity : BaseEntity

@property (nonatomic ,strong)NSString        *itemId;
@property (nonatomic ,strong)NSString        *name;
@property (nonatomic ,assign)double           price;
@property (nonatomic ,assign)int              amount;
@property (nonatomic ,assign)double           pricePreferential;
@property (nonatomic ,assign)double           settlementPrice;

+ (NSArray *)parseStandardListWithJson:(id)json;
+ (ItemsEntity *)parseStandardEntityWithJson:(id)json;
@end

/*
"itemId":<long>                       //商品编码
"name":<String>                       //商品名称
"price":<double>                      //原价
"amount":<int>                        //商品数量
"pricePreferential":<double>          //优惠价格
"standards"<String>                   //商品规格
*/

