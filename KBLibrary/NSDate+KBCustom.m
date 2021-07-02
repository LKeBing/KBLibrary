//
//  NSDate+KBCustom.m
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import "NSDate+KBCustom.h"

@implementation NSDate (KBCustom)
+ (NSDate *)nextDate {
    return [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
}
+ (NSDate *)lastDate {
    return [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]];;
}
//传入时间返回星期几
- (NSString*)weekdayString {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//公历
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    return [weekdays objectAtIndex:theComponents.weekday];
}

- (NSString*)simpleTimeStringSinceNow {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.timeZone=[NSTimeZone systemTimeZone];
    dateFormatter.dateFormat=@"YYYY-MM-dd";
    NSString *dateStr = [dateFormatter stringFromDate:self];
    NSInteger seconds = [self timeIntervalSinceNow];
    if (seconds <= 0) {
        
        seconds = ABS(seconds);
        
        if (seconds<60) {
            return @"刚刚";
        }else if (seconds<60*60) {
            return [NSString stringWithFormat:@"%ld分钟前",(long)(seconds/60)];
        }else if (seconds<60*60*24) {
            return [NSString stringWithFormat:@"%ld小时前",(long)(seconds/(60*60))];
        }else {
            return dateStr;
        }
    }else{
        if (seconds<60) {
            return [NSString stringWithFormat:@"%ld秒钟后",(long)seconds];
        }else if (seconds<60*60) {
            return [NSString stringWithFormat:@"%ld分钟后",(long)(seconds/60)];
        }else if (seconds<60*60*24) {
            return [NSString stringWithFormat:@"%ld小时后",(long)(seconds/(60*60))];
        }else if (seconds<60*60*24*60) {
            return [NSString stringWithFormat:@"%ld天后",(long)(seconds/(60*60*24))];
        }else{
            return @"60天后";
        }
    }
    
    return dateStr;
}


@end
