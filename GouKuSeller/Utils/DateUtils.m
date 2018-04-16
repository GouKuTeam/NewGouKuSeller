//
//  DataUtils.m
//  juliye-iphone
//
//  Created by 洪聪 on 15/1/19.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

/********************** NSDate Utils ***********************/
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval formatter:(NSString *)formatter
{
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    return [self stringFromDate:createdDate formatter:formatter];
}

+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([formatter isEqual:@"yyyy-MM-dd a HH:mm"]) {
        [dateFormatter setPMSymbol:@"下午"];
        [dateFormatter setAMSymbol:@"上午"];
    }else if ([formatter isEqual:@"yyyy年MM月dd日 a HH:mm"]){
        [dateFormatter setPMSymbol:@"下午"];
        [dateFormatter setAMSymbol:@"上午"];
    }else if ([formatter isEqual:@" a HH:mm"]) {
        [dateFormatter setPMSymbol:@"下午"];
        [dateFormatter setAMSymbol:@"上午"];
    }else if ([formatter isEqual:@"yyyy-MM-dd a hh:mm"]){
        [dateFormatter setPMSymbol:@"下午"];
        [dateFormatter setAMSymbol:@"上午"];
    }
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateString formatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([formatter isEqual:@"yyyy-MM-dd a HH:mm"]) {
        [dateFormatter setPMSymbol:@"下午"];
        [dateFormatter setAMSymbol:@"上午"];
    }else if ([formatter isEqual:@"yyyy年MM月dd日 a HH:mm"]){
        [dateFormatter setPMSymbol:@"下午"];
        [dateFormatter setAMSymbol:@"上午"];
    }else if ([formatter isEqual:@" a HH:mm"]) {
        [dateFormatter setPMSymbol:@"下午"];
        [dateFormatter setAMSymbol:@"上午"];
    }else if ([formatter isEqual:@"yyyy-MM-dd a hh:mm"]){
        [dateFormatter setPMSymbol:@"下午"];
        [dateFormatter setAMSymbol:@"上午"];
    }

    
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:dateString];
}

//转化YYYYMMDDHH24MISS格式日期
+ (NSString *)transferDateWithFormatDate:(NSString *)date{
    if (date.length!=14) {
        return @"";
    }
    NSString *year = [date substringToIndex:4];
    NSString *month = [date substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [date substringWithRange:NSMakeRange(6, 2)];
    NSString *hour = [date substringWithRange:NSMakeRange(8, 2)];
    NSString *minute = [date substringWithRange:NSMakeRange(10, 2)];
//    NSString *second = [date substringWithRange:NSMakeRange(12, 2)];
    
    return [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
}

+ (NSString *)timeDurationStringWithNumber:(NSInteger)time{
    if (time<0) {
        return @"0秒";
    }
    int second = time%60;
    time = time/60;
    int mimute = time%60;
    int hour = (int)time/60;
    NSString *string = nil;
    if (hour > 0) {
        string = [NSString stringWithFormat:@"%d小时%d分%d秒",hour,mimute,second];
    }else if(mimute > 0){
        string = [NSString stringWithFormat:@"%d分%d秒",mimute,second];
    }else{
        string = [NSString stringWithFormat:@"%d秒",second];
    }
    return string;
}

+ (NSString *)orderStringFromTimeInterval:(NSTimeInterval)timeInterval{
    
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    // 1. 获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSMutableString *formatString = [NSMutableString stringWithString:@"yyyy-MM-dd"];
    
    // 2. 判断是否是今天
    if ([calendar isDateInToday:createdDate]) {
        return @"今天";
    }else {
        NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
        [currentFormatter setDateFormat:formatString];
        [currentFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        return [currentFormatter stringFromDate:createdDate];
    }
}

@end
