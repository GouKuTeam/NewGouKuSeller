//
//  AddressEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/15.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface AddressEntity : BaseEntity

@property (nonatomic ,strong)NSString          *name;
@property (nonatomic ,strong)NSString          *phone;
@property (nonatomic ,strong)NSString          *address;
@property (nonatomic ,strong)NSString          *area;
@property (nonatomic ,strong)NSString          *userShop;     // 商家名称
@property (nonatomic ,assign)int                isDefault;    //是否默认 1 默认地址  0 不是
@property (nonatomic ,assign)int                provinceId;
@property (nonatomic ,assign)int                cityId;
@property (nonatomic ,assign)int                districtId;
@property (nonatomic ,strong)NSString          *provinceName;
@property (nonatomic ,strong)NSString          *cityName;
@property (nonatomic ,strong)NSString          *districtName;
@property (nonatomic ,assign)double             lat;
@property (nonatomic ,assign)double             lon;
@property (nonatomic ,strong)NSString          *houseNum;     //门牌号


+ (NSArray *)parseAddressEntityListWithJson:(id)json;
+ (AddressEntity *)parseAddressEntityWithJson:(id)json
;

@end

/*
"name": <String>,//联系人名称
"phone": <String>//电话
"provinceId":<int> //省id
"cityId":<int> //市id
"districtId":<int> //区id
"provinceName":<String> //省名称
"cityName":<String> //市名称
"districtName":<String> //区名称
"address":<String> //地址
"lat":<double>      //纬度
"lon":<double>      //精度
*/
