//
//  APIConfig.h
//  DocChat
//
//  Created by SeanLiu on 15/8/4.
//  Copyright (c) 2015年 juliye. All rights reserved.
//

#ifndef DocChat_APIConfig_h
#define DocChat_APIConfig_h

//1:正式网 2:测试打包 3:开发联调
#define SERVER_TYPE  3

#if (SERVER_TYPE == 1)
    //appstore环境
    #define SERVER_HOST                 @"webpro.zlycare.com"
    #define SERVER_ZLYHOST              @"wx.zlycare.com"
    #define WEB_HOST                    @"webpro.zlycare.com"
    #define KEY_JPUSH                   @"0b83dc8e9b61f531191e7f61"
    #define Jpush                       @"YES"
#elif (SERVER_TYPE == 2)
    //测试打包
    #define SERVER_HOST                 @"api.zlycare-bate.zlycare.com"
    #define SERVER_ZLYHOST              @"wx-test.zlycare.com"
    #define WEB_HOST                    @"api.zlycare-bate.zlycare.com"
    #define KEY_JPUSH                   @"0b83dc8e9b61f531191e7f61"
    #define Jpush                       @"NO"
#elif (SERVER_TYPE == 3)
    //开发联调
    #define SERVER_HOST                 @"care-dev.zlycare.com"
    #define SERVER_ZLYHOST              @"39.107.202.48:8080"
    #define WEB_HOST                    @"care-dev.zlycare.com"
    #define KEY_JPUSH                   @"0b83dc8e9b61f531191e7f61"
    #define Jpush                       @"NO"
#endif


//HTTP_PROTOCOL 用来区分 http与https
//#define HTTPS_PROTOCOL
#if (SERVER_TYPE == 3)
#define SERVER_PROTOCOL @"https://"
#define OLD_SERVER_PROTOCOL @"http://"
#else
#define SERVER_PROTOCOL @"https://"
#define OLD_SERVER_PROTOCOL @"http://"
#endif

//API VERSION
#define API_VERSION @"/1"


#endif
