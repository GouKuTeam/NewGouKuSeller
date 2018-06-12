//
//  PurchaseOrderEntity.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "BaseEntity.h"
#import "AddressEntity.h"

@interface PurchaseOrderEntity : BaseEntity

//商户端用的
@property (nonatomic ,strong)NSNumber         *shopId;            //商户ID
@property (nonatomic ,strong)NSString         *name;              //商户名称
@property (nonatomic ,strong)NSString         *logo;              //商户LOGO
@property (nonatomic ,strong)NSString         *phone;             //商户联系方式
@property (nonatomic ,strong)NSNumber         *orderId;           //订单ID
@property (nonatomic ,strong)NSString         *remark;            //备注
@property (nonatomic ,strong)NSNumber         *number;            //订单当日序号
@property (nonatomic ,assign)double            payFreight;        //订单运费
@property (nonatomic ,assign)double            payTotal;          //订单总价
@property (nonatomic ,assign)double            payWareTotal;      //商品总价
@property (nonatomic ,assign)double            payReduce;          //优惠金额
@property (nonatomic ,assign)double            payActual;         //订单修改后的价格(实付总价)
@property (nonatomic ,strong)NSNumber         *count;             //订单商品数量
@property (nonatomic ,assign)double            createTime;        //下单时间
@property (nonatomic ,assign)double            payTime;           //付款时间
@property (nonatomic ,assign)long             countDown;          //倒计时(秒)
@property (nonatomic ,strong)NSArray          *items;             //订单商品数组
@property (nonatomic ,strong)NSArray          *flow;              //订单状态描述数组
@property (nonatomic ,strong)NSArray          *actOut;            //订单优惠详情
@property (nonatomic ,strong)AddressEntity    *address;           //地址对象
@property (nonatomic ,assign)double            accountPrice;      //账户余额
//供应商订单加的
@property (nonatomic ,assign)BOOL              isShow;
@property (nonatomic ,assign)BOOL              isFlowShow;


//商户 To C  订单加的
@property (nonatomic ,strong)NSNumber         *orderType;          //订单类型
@property (nonatomic ,strong)NSString         *distribution;      //配送要求
@property (nonatomic ,strong)NSString         *invoice;           //发票抬头
@property (nonatomic ,assign)int               refund;            //用户退款状态 0:无退款，1用户已退款，2用户申请退款，3商户已同意退款
@property (nonatomic ,strong)NSString         *refundReasons;     //用户退款原因
//"status":<number>,          //订单状态(0待付款2待发货3待收货8已完成9已取消)
@property (nonatomic ,assign)double            refundAt;          //用户退款时间


+ (NSArray *)parsePurchaseOrderEntityListWithJson:(id)json;
+ (PurchaseOrderEntity *)parsePurchaseOrderEntityWithJson:(id)json;
@end

/*
 "flow":[                                    //订单变更记录
 {
 "time":<String>,                //变更时间
 "describe":<String>             //变更描述
 }
 ]
 */

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
