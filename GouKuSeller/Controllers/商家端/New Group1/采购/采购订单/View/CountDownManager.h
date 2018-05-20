//
//  CountDownManager.h
//  GouKuSeller
//
//  Created by lixiao on 2018/5/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCountDownManager [CountDownManager manager]
#define kCountDownNotification @"kCountDownNotification"

@interface CountDownManager : NSObject

@property (nonatomic,assign)NSInteger    timeInterval;

+ (instancetype)manager;

- (void)start;

- (void)reload;

@end
