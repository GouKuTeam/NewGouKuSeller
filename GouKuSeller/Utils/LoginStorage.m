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
static NSString * const TYPE = @"TYPE";
static NSString * const SecurityToken = @"securityToken";
static NSString * const AccessKeySecret = @"accessKeySecret";
static NSString * const AccessKeyId = @"accessKeyId";
static NSString * const ISPrinter = @"isPrinter";
static NSString * const PrinterNum = @"PrinterNum";

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
+ (void)saveShopId:(NSString *)str{
    [UserDefaultsUtils saveValue:str forKey:ShopId];
}

+ (NSString *)GetShopId
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
+ (void)saveShopPic:(NSString *)str{
    if ([str isKindOfClass:[NSNull class]]) {
        str = @"";
    }
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
/**
*  存/取 type
*/
+ (void)saveType:(NSString *)typeStr{
    [UserDefaultsUtils saveValue:typeStr forKey:TYPE];
}
+ (NSString *)GetTypeStr{
    return [UserDefaultsUtils valueWithKey:TYPE];
}
/**
 *  存/取 上传图片用的配置
 */
+ (void)saveSecurityToken:(NSString *)securityToken{
    [UserDefaultsUtils saveValue:securityToken forKey:SecurityToken];
}
+ (NSString *)GetSecurityToken{
    return [UserDefaultsUtils valueWithKey:SecurityToken];
}

+ (void)saveAccessKeySecret:(NSString *)accessKeySecret{
    [UserDefaultsUtils saveValue:accessKeySecret forKey:AccessKeySecret];
}
+ (NSString *)GetAccessKeySecret{
    return [UserDefaultsUtils valueWithKey:AccessKeySecret];
}

+ (void)saveAccessKeyId:(NSString *)accessKeyId{
    [UserDefaultsUtils saveValue:accessKeyId forKey:AccessKeyId];
}
+ (NSString *)GetAccessKeyId{
    return [UserDefaultsUtils valueWithKey:AccessKeyId];
}

/**
 *  是否自动打印小票
 */
+ (void)saveIsPrinter:(BOOL)printerStatus{
    [UserDefaultsUtils saveBoolValue:printerStatus withKey:ISPrinter];
}
+ (BOOL)IsPrinter{
    return  [UserDefaultsUtils boolValueWithKey:ISPrinter];
}

/**
 *  打印次数
 */
+ (void)savePrinterNum:(NSString *)printerNum{
    [UserDefaultsUtils saveValue:printerNum forKey:PrinterNum];
}
+ (NSString *)getPrinterNum{
    return  [UserDefaultsUtils valueWithKey:PrinterNum];
}

@end
