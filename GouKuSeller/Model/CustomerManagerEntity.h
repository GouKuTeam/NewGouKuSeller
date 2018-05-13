//
//  CustomerManagerEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/11.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface CustomerManagerEntity : BaseEntity

@property (nonatomic ,strong)NSNumber       *shopId;
@property (nonatomic ,strong)NSString       *shopName;         //店铺名称
@property (nonatomic ,strong)NSString       *personName;       //姓名
@property (nonatomic ,strong)NSString       *phone;            //电话
@property (nonatomic ,strong)NSString       *address;          //地址
@property (nonatomic ,strong)NSString       *logo;
@property (nonatomic ,strong)NSNumber       *moneySum;         //销售总额
@property (nonatomic ,strong)NSNumber       *orderNum;         //订单数量
@property (nonatomic ,assign)double          lat;               //纬度
@property (nonatomic ,assign)double          lon;               //经度

+ (NSArray *)parseCustomerManagerListWithJson:(id)json;
+ (CustomerManagerEntity *)parseCustomerManagerEntityWithJson:(id)json;

@end
