//
//  CountDownManager.m
//  GouKuSeller
//
//  Created by lixiao on 2018/5/17.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "CountDownManager.h"


@interface CountDownManager()

@property (nonatomic,strong)NSTimer     *timer;

@end

@implementation CountDownManager

+ (instancetype)manager{
    static CountDownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CountDownManager alloc]init];
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
    [[NSNotificationCenter defaultCenter]postNotificationName:kCountDownNotification object:nil userInfo:@{@"TimeTnterval":@(self.timeInterval)}];
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
