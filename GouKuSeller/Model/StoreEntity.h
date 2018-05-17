//
//  StoreEntity.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface StoreEntity : BaseEntity
@property (nonatomic,strong)NSNumber     *shopId;           //供应商门店ID
@property (nonatomic,strong)NSString     *name;             //供应商门店名称
@property (nonatomic,assign)NSInteger    orderNum;         //订单数量
@property (nonatomic,assign)NSInteger    shopNum;          //订购的店铺数
@property (nonatomic,strong)NSArray      *industry;         //品类 数组
@property (nonatomic,strong)NSArray      *agencyBrand;      //代理的品牌  数组
@property (nonatomic,strong)NSString     *logo;             //供应商门店LOGO
@property (nonatomic,assign)double       takeOffPrice;      //供应商门店起送价格
@property (nonatomic,assign)BOOL         isAttention;      //是否关注 0 未关注 1 已关注
@property (nonatomic,strong)NSString     *phone;            //事务人电话

@property (nonatomic,assign)double       orderPrice;        //供应商门店订单总价
@property (nonatomic,assign)double       freightPrice;      //供应商门店运费
@property (nonatomic,strong)NSArray      *shoppingCatItems; //供应商门店订单商品
@property (nonatomic,strong)NSString     *remark;

@property (nonatomic,assign)BOOL         isSelected;


+ (NSArray *)parseStoreListWithJson:(id)json;
+ (StoreEntity *)parseStoreEntityWithJson:(id)json;

@end
/*
"shopId":<number>
"name":<String>                 //供应商名称
"orderNum":<Integer>            //订单数量
"shopNum":<Integer>             //订购的店铺数
"industry":<[String]>           //品类 数组
"logo":<String>                 //logo
"agencyBrand":<[String]>        //代理的品牌  数组
"takeOffPrice":<number>         //起送价
"isAttention":<num>             //是否关注 0 未关注 1 已关注
"phone":<String>                //事务人电话
 */
