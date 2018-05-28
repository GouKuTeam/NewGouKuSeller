//
//  DocChatDefines.h
//  DocChat
//
//  Created by SeanLiu on 15/8/4.
//  Copyright (c) 2015年 juliye. All rights reserved.
//

#ifndef DocChat_iphone_DocChatDefines
#define DocChat_iphone_DocChatDefines

//包含状态栏导航栏高度高度
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define APP_WIDTH  [UIScreen mainScreen].applicationFrame.size.width
#define APP_HEIGHT [UIScreen mainScreen].applicationFrame.size.height

#define STATUSBAR_VER_HEIGHT        20
#define NAVIGATIONBAR_VER_HEIGHT    64

//-------------------------------文案-------------------------------------
//error信息提示
#define TEXT_NETWORK_ERROR       @"网络异常,请检查网络连接"
#define TEXT_SERVER_NOT_RESPOND  @"服务器或网络异常,请稍后重试"
#define ERROR_NETWORK_TEXT       @"当前网络不可用,请检查你的网络设置\n点击屏幕刷新"
#define ERROR_DATA_TEXT          @"点击屏幕,重新加载"

//-----------------------UI Colors-----------------------------
#define COLOR_BLUE_MAIN             @"#4167B2"
#define COLOR_NEW_TEXTDESC          @"#b9b9b9"
#define COLOR_GRAY_BG               @"#EFEFEF"
#define COLOR_LINE_LIGHTGRAY        @"#e0e0e0"
#define COLOR_TOUCHDOWN             @"#F0F0F0"
#define COLOR_TEXT_HARDGRAY         @"#000000"
#define COLOR_TEXT_DESCGRAY         @"#616161"
#define COLOR_NAVI_DEFAULT          @"#666666"
#define COLOR_Main                  @"#38393e"

//-----------------------UI SPACING----------------------------
//新布局间距
#define SPACING_TEXT              7
#define SPACING_CONTROLS          12
#define SPACING_BUTTON            15
#define SPACING_ORDER_DETAIL      16

//-----------------------UI FONT--------------------------------
#define FONT_SIZE_TITLE         16
#define FONT_SIZE_DESC          14
#define FONT_SIZE_MEMO          12

//------------------------------DATE FORMATTER-----------------------------------
#define DATE_FORMATTER_DEFAULT      @"yyyy-MM-dd HH:mm"
#define DATE_FORMATTER_ONLYDATE     @"yyyy年MM月dd日"

//wx
#define NF_WECHAT_PAY_SUCCESS       @"NF_WECHAT_PAY_SUCCESS"   //微信支付成功
#define NF_WECHAT_PAY_USER_CANCEL   @"NF_WECHAT_PAY_USER_CANCEL"

#endif
