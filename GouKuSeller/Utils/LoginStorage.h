//
//  LoginStorage.h
//  小趣用户端
//
//  Created by 窦建斌 on 16/1/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDefaultsUtils.h"
@interface LoginStorage : NSObject


+ (void)savePhoneNum:(NSString *)str;

+ (NSString *)GetPhoneNum;

+ (void)saveYanZhengMa:(NSString *)str;

+ (NSString *)GetYanZhengMa;

+ (void)saveIsLogin:(BOOL)loginStatus;

+ (BOOL)isLogin;

+ (void)saveHTTPHeader:(NSString *)str;
+ (NSString *)GetHTTPHeader;

+ (void)saveShopId:(NSNumber *)str;
+ (NSNumber *)GetShopId;

+ (void)saveUserName:(NSString *)str;
+ (NSString *)GetUserName;

+ (void)saveShopName:(NSString *)str;
+ (NSString *)GetShopName;

+ (void)saveShopPic:(NSString *)str;
+ (NSString *)GetShopPic;

+ (void)saveGouWuChe:(NSMutableArray *)arr;
+ (NSMutableArray *)GetGouWuChe;

+ (void)saveType:(NSString *)typeStr;
+ (NSString *)GetTypeStr;

+ (void)saveSecurityToken:(NSString *)securityToken;
+ (NSString *)GetSecurityToken;

+ (void)saveAccessKeySecret:(NSString *)accessKeySecret;
+ (NSString *)GetAccessKeySecret;

+ (void)saveAccessKeyId:(NSString *)accessKeyId;
+ (NSString *)GetAccessKeyId;

+ (void)saveIsPrinter:(BOOL)printerStatus;
+ (BOOL)IsPrinter;

+ (void)savePrinterNum:(NSString *)printerNum;
+ (NSString *)getPrinterNum;
@end
