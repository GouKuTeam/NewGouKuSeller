//
//  DataUtils.h
//  juliye-iphone
//
//  Created by 洪聪 on 15/1/19.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval formatter:(NSString *)formatter;

+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;

+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter;


//转化通话时长
+ (NSString *)timeDurationStringWithNumber:(NSInteger)time;

//转化YYYYMMDDHH24MISS格式日期
+ (NSString *)transferDateWithFormatDate:(NSString *)date;
+ (NSString *)orderStringFromTimeInterval:(NSTimeInterval)timeInterval;
@end
