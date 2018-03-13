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
#endif
