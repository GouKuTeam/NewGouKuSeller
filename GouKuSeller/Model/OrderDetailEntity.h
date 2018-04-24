//
//  OrderDetailEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/4/13.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"

@interface OrderDetailEntity : BaseEntity

@property (nonatomic ,assign)double          createAt;
@property (nonatomic ,assign)int             dealType;
@property (nonatomic ,assign)double          deleteAt;
@property (nonatomic ,assign)int             isDeleted;
@property (nonatomic ,strong)NSString        *orderId;
@property (nonatomic ,strong)NSString        *shopId;
@property (nonatomic ,strong)NSArray         *items;     //商品数组对象
@property (nonatomic ,assign)double          loseSmallReduce;   //去零金额
@property (nonatomic ,assign)double          noGoods;           //无码商品金额
@property (nonatomic ,assign)double          orderDiscount;     //整单折扣金额
@property (nonatomic ,assign)double          orderMinus;     //整单立减金额
@property (nonatomic ,assign)double          payActual;     //实付金额
@property (nonatomic ,assign)double          payDate;     //支付时间
@property (nonatomic ,assign)double          payReduce;     //优惠金额
@property (nonatomic ,assign)double          payTotal;     //总价金额
@property (nonatomic ,assign)int             payType;      //支付类型  1.购酷支付  2.现金支付
//@property (nonatomic ,assign)int             _status;      //订单状态  1.待支付 2.已完成 
@property (nonatomic ,assign)double          updateAt;

@property (nonatomic ,assign)double          date;           //订单列表一级菜单显示的时间




+ (NSArray *)parseStandardListWithJson:(id)json;
+ (OrderDetailEntity *)parseStandardEntityWithJson:(id)json;

@end
