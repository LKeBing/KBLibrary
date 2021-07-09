//
//  NSDate+KB.h
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kbMinuteTimeInterval    60.f //1分钟间隔秒数
#define kbHourTimeInterval      (kbMinuteTimeInterval * 60) //1小时间隔秒数
#define kbDayTimeInterval       (kbHourTimeInterval * 24) //1天间隔秒数
#define kbWeekTimeInterval      (kbDayTimeInterval * 7) //1星期间隔秒数

/**yyyy-MM-dd HH:mm:ss*/
static NSString * _Nullable const dateFormat1 = @"yyyy-MM-dd HH:mm:ss";
/**yyyy-MM-dd*/
static NSString * _Nullable const dateFormat2 = @"yyyy-MM-dd";
/**yyyy年MM月dd日*/
static NSString * _Nullable const dateFormat3 = @"yyyy年MM月dd日";
/**HH小时mm分*/
static NSString * _Nullable const dateFormat4 = @"HH小时mm分";
/**HH:mm*/
static NSString * _Nullable const dateFormat5 = @"HH:mm";
/**yyyy-MM-dd HH:mm*/
static NSString * _Nullable const dateFormat6 = @"yyyy-MM-dd HH:mm";
/**yyyy-MM-dd*/
static NSString * _Nullable const dateFormat7 = @"yyyy/MM/dd";
/**yyyy/MM/dd HH:m*/
static NSString * _Nullable const dateFormat8 = @"yyyy/MM/dd HH:mm";
/**yyyyMMdd*/
static NSString * _Nullable const dateFormat9 = @"yyyyMMdd";
/**MM-dd HH:mm*/
static NSString * _Nullable const dateFormat10 = @"MM-dd HH:mm";
/**MM-dd*/
static NSString * _Nullable const dateFormat11 = @"MM-dd";
/**@"yyyy-MM-dd'T'HH:mm:ssZ"*/
static NSString * _Nullable const ISODateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";


@interface NSDateFormatter (KB)
+ (NSDateFormatter *)kb_dateFormatterWithformat:(NSString *)format;
+ (NSDateFormatter *)kb_dateFormatterWithformat:(NSString *)format timeZone:(NSTimeZone *_Nullable)timeZone locale:(NSLocale *_Nullable)locale;
@end

@interface NSDate (KB)

/**
 时间字符串转时间：NSString --->  NSDate
 */
+ (NSDate *)kb_dateFromString:(NSString *)string format:(NSString *)format;
+ (NSDate *)kb_dateFromString:(NSString *)string format:(NSString *)format timeZone:(NSTimeZone *_Nullable)timeZone locale:(NSLocale *_Nullable)locale;
+ (NSDate *)kb_dateFromISOFormatString:(NSString *)string;

/**
 时间转时间字符串：NSDate --->  NSString
 */
- (NSString *)kb_stringWithFormat:(NSString *)format;
- (NSString *)kb_stringWithFormat:(NSString *)format timeZone:(NSTimeZone *_Nullable)timeZone locale:(NSLocale *_Nullable)locale;
- (NSString *)kb_stringWithISOFormat;

/**
 用一个时间得到另一个时间：NSDate ---> NSDate
 */
- (NSDate *)kb_dateByAddingYears:(NSInteger)years;
- (NSDate *)kb_dateByAddingMonths:(NSInteger)months;
- (NSDate *)kb_dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)kb_dateByAddingDays:(NSInteger)days;
- (NSDate *)kb_dateByAddingHours:(NSInteger)hours;
- (NSDate *)kb_dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)kb_dateByAddingSeconds:(NSInteger)seconds;
- (NSDate *)kb_nextDate;
- (NSDate *)kb_lastDate;


+ (NSDate *)kb_yesterday;
+ (NSDate *)kb_tomorrow;

- (BOOL)kb_isToday;
- (BOOL)kb_isYesterday;
- (BOOL)kb_isTomorrow;

@end

/// 该类主要是用于处理常见的服务器时间转换
@interface NSDate (KBServer)

/**
 将服务器返回的时间戳转为时间字符串
 */
+ (NSString *)kb_stringWithSecondIntervalSince1970:(NSNumber *)secsNum format:(NSString *)format;
+ (NSString *)kb_stringWithMillisecondIntervalSince1970:(NSNumber *)mSecsNum format:(NSString *)format;

/**
 将服务器返回的时间字符串转换为另外一种格式的时间字符串
 */
+ (NSString *)kb_stringFromOriginalString:(NSString *)string originalFormat:(NSString *)originalFormat finalFormat:(NSString *)finalFormat;

@end

@interface NSDate (KBCalender)

- (NSInteger)kb_era;
- (NSInteger)kb_year;
- (NSInteger)kb_month;
- (NSInteger)kb_day;
- (NSInteger)kb_hour;
- (NSInteger)kb_minute;
- (NSInteger)kb_second;
- (NSInteger)kb_nanosecond;
- (NSInteger)kb_weekday;
- (NSInteger)kb_weekdayOrdinal;
- (NSInteger)kb_weekOfMonth;
- (NSInteger)kb_weekOfYear;
- (NSInteger)kb_yearForWeekOfYear;
- (NSInteger)kb_quarter;

- (BOOL)kb_isLeapMonth;
- (BOOL)kb_isLeapYear;

- (NSString *)kb_weekdayText;

@end

@interface NSDate (KBPrivate)

@end

NS_ASSUME_NONNULL_END
