//
//  PurchaseOrderEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface PurchaseOrderEntity : BaseEntity

@property (nonatomic ,strong)NSNumber         *shopId;            //商户ID
@property (nonatomic ,strong)NSString         *name;              //商户名称
@property (nonatomic ,strong)NSString         *logo;              //商户LOGO
@property (nonatomic ,strong)NSString         *phone;             //商户联系方式
@property (nonatomic ,strong)NSNumber         *orderId;           //订单ID
@property (nonatomic ,strong)NSNumber         *number;            //订单当日序号
@property (nonatomic ,assign)double            payFreight;        //订单运费
@property (nonatomic ,assign)double            payTotal;          //订单总价
@property (nonatomic ,strong)NSNumber         *count;             //订单商品数量
@property (nonatomic ,assign)NSNumber         *createTime;        //下单时间
@property (nonatomic ,assign)NSNumber         *payTime;           //付款时间
@property (nonatomic ,strong)NSArray          *items;             //订单商品数组

//"status":<number>,          //订单状态(0待付款1待接单2待发货3待收货8已完成9已取消)

+ (NSArray *)parsePurchaseOrderEntityListWithJson:(id)json;
+ (PurchaseOrderEntity *)parsePurchaseOrderEntityWithJson:(id)json;
@end


/*
 "shopId":<number>,          //商户ID
 "name":<String>,            //商户名称
 "logo":<String>,            //商户LOGO
 "phone":<String>,           //商户联系方式
 "orderId":<number>,         //订单ID
 "number":<number>,          //订单当日序号
 "payFreight":<Decimal>,     //订单运费
 "payTotal":<Decimal>,       //订单总价
 "count":<number>,           //订单商品数量
 "createTime":<number>,      //下单时间
 "payTime":<number>,         //付款时间
 "status":<number>,          //订单状态(0待付款1待接单2待发货3待收货8已完成9已取消)
 "items":[
 {
 "orderId":<number>,         //订单所属ID
 "skuId":<number>,           //商品SKUID
 "skuUnitId":<number>,       //商品单位ID
 "unit":<String>,            //商品单位名称
 "count":<number>,           //商品数量
 "name":<String>,            //商品名称
 "pictures":<Decimal>,       //商品价格
 "standards":<String>        //商品属性
 }
 ]
 */
