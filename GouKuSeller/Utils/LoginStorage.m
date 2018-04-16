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
static NSString * const UserName = @"UserName";
static NSString * const ShopPic = @"ShopPic";
static NSString * const ShopName = @"ShopName";
static NSString * const GOUWUCHE = @"gouwuche";


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

/**
 *  存/取  用户名
 */
+ (void)saveUserName:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:UserName];
}

+ (NSString *)GetUserName
{
    return [UserDefaultsUtils valueWithKey:UserName];
}
/**
 *  存/取  店铺头像
 */
+ (void)saveShopMsg:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:ShopPic];
}

+ (NSString *)GetShopPic
{
    return [UserDefaultsUtils valueWithKey:ShopPic];
}
/**
 *  存/取  店铺名字
 */
+ (void)saveShopName:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:ShopName];
}

+ (NSString *)GetShopName
{
    return [UserDefaultsUtils valueWithKey:ShopName];
}

/**
 *  存/取  购物车
 */
+ (void)saveGouWuChe:(NSMutableArray *)arr{
    [UserDefaultsUtils saveValue:arr forKey:GOUWUCHE];
}

+ (NSMutableArray *)GetGouWuChe
{
    return [UserDefaultsUtils valueWithKey:GOUWUCHE];
}

@end
