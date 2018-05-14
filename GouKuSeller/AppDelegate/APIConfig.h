//
//  APIConfig.h
//  DocChat
//
//  Created by SeanLiu on 15/8/4.
//  Copyright (c) 2015年 juliye. All rights reserved.
//

#ifndef DocChat_APIConfig_h
#define DocChat_APIConfig_h
/*
 http://47.97.174.40:9001
 http://47.97.174.40:9000
 */



//1:正式网 2:测试打包
#define SERVER_TYPE  2

#if (SERVER_TYPE == 1)
    //appstore环境
    #define API_Login                   @"https://passport.goukugogo.com"
    #define API_OrderAndPay             @"https://trade.goukugogo.com"
    #define API_Other                   @"https://shop.goukugogo.com"
    #define KEY_JPUSH                   @"a39c6215cc0d16b9dd42db44"
    #define Jpush                       @"YES"
    #define SERVER_HOST                 @"47.97.174.40:9001"

#elif (SERVER_TYPE == 2)
    //测试打包
    #define API_Login                   @"http://47.97.174.40:9000"
    #define API_OrderAndPay             @"http://47.97.174.40:9002"
    #define API_Other                   @"http://47.97.174.40:9001"
    #define KEY_JPUSH                   @"a39c6215cc0d16b9dd42db44"
    #define Jpush                       @"NO"
    #define SERVER_HOST                 @"47.97.174.40:9001"
#endif

//HTTP_PROTOCOL 用来区分 http与https
//#define HTTPS_PROTOCOL
#if (SERVER_TYPE == 2)
#define SERVER_PROTOCOL @"http://"
#else
#define SERVER_PROTOCOL @"https://"
#endif
    #define SERVER_HOST                 @"47.97.174.40:9001"
//JPUSH
#define JPushAppKey @"a39c6215cc0d16b9dd42db44"

//API VERSION
#define API_VERSION @""
//头像前缀
#define HeadQZ @"http://pea-shop.oss-cn-hangzhou.aliyuncs.com/"

/*
     商品API
 */

//店内分类列表
#define API_GET_ShopCommodityCategory @"/shop/ware/category/all/"
//分类下店内商品列表
#define API_GET_CommodityInformation @"/shop/ware/item/list"
//商品类目列表
#define API_GET_CommodityCatahory @"/ware/category/list/%@"
//通过商品分类获取商品规格值
#define API_GET_Standard @"/ware/standard/list/%@"
//通过条形码获取商品信息
#define API_GET_CommodityInformationFromBarCode @"/ware/"
//获取店内分类
#define API_GET_ShopCatagory @"/shop/category/list"
//添加店内分类
#define API_GET_AddShopCatagory @"/shop/ware/category/add"
//删除店内分类
#define API_GET_DelShopCatagory @"/shop/ware/category/delete"
//修改店内分类
#define API_GET_UdpShopCatagory @"/shop/ware/category/update"
//新增商品
#define API_GET_AddCommodity @"/shop/ware/stock/add"
//商品查询
#define API_GET_CommodityList @"/shop/ware/stock/list"
//搜索商品
#define API_GET_SearchCommodity @"/shop/ware/stock/search"
//门店商品下架
#define API_GET_downshelf @"/shop/ware/stock/downshelf/"
//门店商品上架
#define API_GET_upshelf @"/shop/ware/stock/upshelf/"
//门店商品删除
#define API_GET_CommodityDelete @"/shop/ware/stock/delete/"
//门店商品编辑
#define API_GET_CommodityEdit @"/shop/ware/stock/update"


/*
 供应商商品API
 */
//供应商商品列表查询  查询所有商品(后台管理)
#define API_POST_SupplierCommodityList @"/wareSku/manage/list"
//供应商新增商品
#define API_POST_AddSupplierCommdity @"/wareSku/manage/addOrUpdate"
//供应商商品修改
#define API_POST_UpdateSupplierCommodity @"/wareSku/manage/addOrUpdate"
//供应商修改商品状态
#define API_POST_UpdateSupplierCommodityStatus @"/wareSku/manage/updateStatus"
//供应商商品删除
#define API_POST_SupplierCommodityDelete @"/wareSku/manage/delete/"
//获取商品详情
#define API_POST_GETSupplierCommodityInformation @"/wareSku/show/get/"

/*
 活动API
 */
// 添加活动
#define API_POSTactivityAdd @"/act/addOrUpdate"
//查询所有活动
#define API_POST_AllActList  @"/act/list"
//停止活动
#define API_POST_STOPACTIVE @"/act/stop/"
//查看活动详情
#define API_GET_SELECTACTIVE @"/act/detail/"


/*
 结算API
 */
//结算信息 （结算首页）
#define API_POST_AccountShow @"/account/show"
//余额明细
#define API_POST_AccountDetails @"/account/details"
//获取银行列表
#define API_POST_bankMessage @"/account/bank/message"
//添加银行卡获取验证码
#define API_POST_AccountCode @"/account/get/code"
//添加银行卡
#define API_POST_addBankCard @"/account/add/bankCard"
//提现校验密码
#define API_POST_checkPassword @"/account/checkPassword"
//提现详情
#define API_POST_CashDetail @"/account/cash/detail"
//微信充值
#define API_POST_WEIXINchongzhi @"/account/recharge/weixin"

/*
 收银API
 */
//扫码添加商品到购物车
#define API_POST_CommodityCashier @"/shop/ware/stock"
//提交订单
#define API_POST_AddOrder @"/order/add"
//扫描用户付款吗上传
#define API_POST_ScanUserCashCode @"/weixin/pay/swiping"
//查询满减活动金额
#define API_POST_SelectManJianPrice @"/shop/act/order"

/*
 订单API
 */
//订单列表查询
#define API_POST_OrderList @"/order/list"
//订单详情查询
#define API_POST_OrderDetail @"/order/details"
//订单搜索
#define API_POST_OrderSearch @"/order/search"

//商机门店列表
#define API_POST_MINEShoplist @"/mine/shoplist"
#endif

/*
 工作台API
 */
#define API_GET_GetToday @"/operate/getToday"

/*
 采购API
 */
//购物车列表
#define API_GET_SHOPPINGLIST @"/shopping/get"
//所有类目
#define API_GET_ALLCATEGORY @"/common/industry/list"
//类目搜索供应商
#define API_GET_SUPPLIERWITHCATEGORY @"/supplier/search/industry"
//名字搜索供应商
#define API_POST_SearchSupplier @"/supplier/search"
//查询所有商品
#define API_GET_WARE @"/wareSku/show/list"

/*
 客户管理API
 */
//获取客户管理列表
#define API_POST_GetCustomerList @"/supplier/customer/list"
//搜索客户
#define API_POST_SearchCustomer @"/supplier/search/customer/"


/*
 盘点API
 */
//查询盘点列表
#define API_GET_InventroyList @"/inventory/list/"
//通过条形码查询商品库存
#define API_POST_SelectInventoryInformation @"/inventory/ware/"
//盘点记录新增
#define API_POST_AddInventory @"/inventory/addOrUpdate"
//删除一条盘点记录
#define API_GET_DeleteInventory @"/inventory/delete/"
//查询一条盘点记录
#define API_GET_SelectInventoryDetail @"/inventory/detail/"
//盘点记录修改
#define API_POST_InventoryUpdate @"/inventory/addOrUpdate"

