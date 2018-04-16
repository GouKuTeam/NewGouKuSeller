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

+ (void)saveGouWuChe:(NSMutableArray *)arr;
+ (NSMutableArray *)GetGouWuChe;
@end
