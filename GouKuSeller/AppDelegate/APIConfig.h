//
//  APIConfig.h
//  DocChat
//
//  Created by SeanLiu on 15/8/4.
//  Copyright (c) 2015年 juliye. All rights reserved.
//

#ifndef DocChat_APIConfig_h
#define DocChat_APIConfig_h

//1:正式网 2:测试打包
#define SERVER_TYPE  2

#if (SERVER_TYPE == 1)
    //appstore环境
    #define SERVER_HOST                 @"webpro.zlycare.com"
    #define KEY_JPUSH                   @"0b83dc8e9b61f531191e7f61"
    #define Jpush                       @"YES"
#elif (SERVER_TYPE == 2)
    //测试打包
    #define SERVER_HOST                 @"47.97.174.40:9001"
    #define KEY_JPUSH                   @"0b83dc8e9b61f531191e7f61"
    #define Jpush                       @"NO"
#endif

//HTTP_PROTOCOL 用来区分 http与https
//#define HTTPS_PROTOCOL
#if (SERVER_TYPE == 2)
#define SERVER_PROTOCOL @"http://"
#else
#define SERVER_PROTOCOL @"https://"
#endif

//API VERSION
#define API_VERSION @""
//店内分类列表
#define API_GET_ShopCommodityCategory @"/shop/ware/category/all/%@"
//分类下店内商品列表
#define API_GET_CommodityInformation @"/shop/ware/item/list"
//商品类目列表
#define API_GET_CommodityCatahory @"/ware/category/list/%@"
//通过商品分类获取商品规格值
#define API_GET_Standard @"/ware/standard/list/%@"
//通过条形码获取商品信息
#define API_GET_CommodityInformationFromBarCode @"/ware/%@"
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
#define API_GET_downshelf @"/shop/ware/stock/downshelf/%@"
//门店商品上架
#define API_GET_upshelf @"/shop/ware/stock/upshelf/%@"
//门店商品删除
#define API_GET_CommodityDelete @"/shop/ware/stock/delete/%@"
#endif
