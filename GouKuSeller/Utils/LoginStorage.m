//
//  LoginStorage.m
//  小趣用户端
//
//  Created by 窦建斌 on 16/1/16.
//  Copyright © 2016年 窦建斌. All rights reserved.
//

#import "LoginStorage.h"

static NSString * const ISLOGIN = @"isLogin";
static NSString * const HttpHeader = @"httpHeader";
static NSString * const PhoneNum = @"PhoneNum";
static NSString * const YanZhengMa = @"YanZhengMa";
static NSString * const ShopId = @"ShopId";

@implementation LoginStorage

/**
 *  存/取  手机号
 */
+ (void)savePhoneNum:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:PhoneNum];
}

+ (NSString *)GetPhoneNum
{
    return [UserDefaultsUtils valueWithKey:PhoneNum];
}

/**
 *  存/取  验证码
 */
+ (void)saveYanZhengMa:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:YanZhengMa];
}

+ (NSString *)GetYanZhengMa
{
    return [UserDefaultsUtils valueWithKey:YanZhengMa];
}

/**
 *  登陆成功
 */
+ (void)saveIsLogin:(BOOL)loginStatus{
    [UserDefaultsUtils saveBoolValue:loginStatus withKey:ISLOGIN];
}
+ (BOOL)isLogin{
    return  [UserDefaultsUtils boolValueWithKey:ISLOGIN];
}

/**
 *  存/取  登陆成功返回的 的 HTTP header
 */
+ (void)saveHTTPHeader:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:HttpHeader];
}

+ (NSString *)GetHTTPHeader
{
    return [UserDefaultsUtils valueWithKey:HttpHeader];
}

/**
 *  存/取  登陆成功返回的 的 ShopId
 */
+ (void)saveShopId:(NSNumber *)str{
    [UserDefaultsUtils saveValue:str forKey:ShopId];
}

+ (NSNumber *)GetShopId
{
    return [UserDefaultsUtils valueWithKey:ShopId];
}



@end
