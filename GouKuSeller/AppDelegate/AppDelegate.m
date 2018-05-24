//
//  AppDelegate.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/3/4.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CommodityViewController.h"
#import "LoginStorage.h"
#import "RTHttpClient.h"

#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <WXApi.h>


@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgrounTask;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    UIViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *navLogin = [[UINavigationController alloc] initWithRootViewController:loginVC];
    if ([LoginStorage isLogin] == YES) {
        if ([[LoginStorage GetTypeStr] isEqualToString:@"1"]) {
            self.tableBarController = [[TabBarViewController alloc] init];
            self.window.rootViewController = self.tableBarController;
        }
        if ([[LoginStorage GetTypeStr] isEqualToString:@"3"]) {
            self.supplierTabbarViewController = [[SupplierTabbarViewController alloc] init];
            self.window.rootViewController = self.supplierTabbarViewController;
        }
    }else{
        self.window.rootViewController = navLogin;
    }
    [self setNavigationBarAndStatusBar];
    
//    //极光推送
    // 3.0.0及以后版本注册可以这样写，也可以继续用旧的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //      NSSet<UNNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
        //    else {
        //      NSSet<UIUserNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    BOOL isProduction;
    if ([Jpush isEqualToString:@"YES"]) {
        isProduction = YES;
    }else{
        isProduction = NO;
    }
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:KEY_JPUSH
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
//            NSString *strUrl = @"http://47.97.174.40:9000/registionid/set";
            NSString *strUrl = [NSString stringWithFormat:@"%@/registionid/set",API_Login];
            NSDictionary *dic = @{@"registionid":registrationID};
            RTHttpClient *asas = [[RTHttpClient alloc]init];
            [asas requestWithPath:strUrl method:RTHttpRequestPost parameters:dic prepare:^{
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
               
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"error == %@",error);
                
            }];
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    [AMapServices sharedServices].apiKey = @"2c81b2b54c03fbdabdbcde8c90d0617c";
    [WXApi registerApp:@"wxf5cfccf099ab98d4"];
    return YES;
}

- (void)setNavigationBarAndStatusBar{
    //设置导航栏和状态栏背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:COLOR_Main]];
    //设置navigationbar上返回按钮和barbutton的字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //设置navigationbar标题的字体和颜色
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          [UIFont boldSystemFontOfSize:17.0], NSFontAttributeName, nil]];
    //设置statusBar为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [UITableView appearance].estimatedRowHeight = 0;
    [UITableView appearance].estimatedSectionHeaderHeight = 0;
    [UITableView appearance].estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}




- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];

}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容

    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //程序在前台
//        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cashcomplete" object:nil userInfo:nil];
    }
    else {
        // 程序打开走这里拿到通知信息
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容

    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
//        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cashcomplete" object:nil userInfo:nil];
    }
    else {
        // 判断为本地通知
       NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        
    }
    completionHandler();  // 系统要求执行这个方法
}


#pragma mark 获取自定义消息内容

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    
    NSString *content = [userInfo valueForKey:@"content"];
    
    NSDictionary *dic =  [self dictionaryWithJsonString:content];
   
    NSLog(@"dic = %@",dic);
    if ([[dic objectForKey:@"type"] intValue] == 1 && [[dic objectForKey:@"status"] intValue] == 0) {
        //收银  用户付款成功
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cashcomplete" object:nil userInfo:nil];
    }
    if ([[dic objectForKey:@"type"] intValue] == 2 && [[dic objectForKey:@"status"] intValue]== 0) {
        //采购订单   用户支付成功已下单  发送通知给订单处理界面刷新数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshSupplierOrderData" object:nil userInfo:nil];
        
    }

}
#endif

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self backgroundMode];
}


-(void)backgroundMode{
    //创建一个背景任务去和系统请求后台运行的时间
    self.backgrounTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.backgrounTask];
        self.backgrounTask = UIBackgroundTaskInvalid;
    }];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(applyToSystemForMoreTime) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)applyToSystemForMoreTime {
    if ([UIApplication sharedApplication].backgroundTimeRemaining < 30.0) {//如果剩余时间小于30秒
        [[UIApplication sharedApplication] endBackgroundTask:self.self.backgrounTask];
        self.backgrounTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:self.self.backgrounTask];
            self.self.backgrounTask = UIBackgroundTaskInvalid;
        }];
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
