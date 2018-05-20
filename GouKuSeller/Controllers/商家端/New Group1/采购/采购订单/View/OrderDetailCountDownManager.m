//
//  OrderDetailCountDownManager.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/19.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "OrderDetailCountDownManager.h"

@interface OrderDetailCountDownManager()

@property (nonatomic,strong)NSTimer     *timer;

@end

@implementation OrderDetailCountDownManager

+ (instancetype)manager{
    static OrderDetailCountDownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OrderDetailCountDownManager alloc]init];
    });
    return manager;
}

- (void)start{
    [self timer];
}

- (void)reload{
    self.timeInterval = 0;
}

- (void)timerAction{
    self.timeInterval ++;
    [[NSNotificationCenter defaultCenter]postNotificationName:OrderDetailCountDownNotification object:nil userInfo:@{@"TimeTnterval":@(self.timeInterval)}];
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
