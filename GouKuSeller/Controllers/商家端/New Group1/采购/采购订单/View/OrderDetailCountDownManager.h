//
//  OrderDetailCountDownManager.h
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DetailCountDownManager [OrderDetailCountDownManager manager]
#define OrderDetailCountDownNotification @"OrderDetailCountDownNotification"

@interface OrderDetailCountDownManager : NSObject

@property (nonatomic,assign)NSInteger    timeInterval;

+ (instancetype)manager;

- (void)start;

- (void)reload;

@end
