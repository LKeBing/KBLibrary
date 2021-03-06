//
//  NSDate+KB.m
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import "NSDate+KB.h"
#import "NSObject+KB.h"

@implementation NSDateFormatter (KB)

+ (NSDateFormatter *)kb_dateFormatterWithformat:(NSString *)format {
    return [self kb_dateFormatterWithformat:format timeZone:nil locale:nil];
}

+ (NSDateFormatter *)kb_dateFormatterWithformat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return formatter;
}

@end

@implementation NSDate (KB)

- (BOOL)kb_isToday {
    if (fabs(self.timeIntervalSinceNow) >= kbDayTimeInterval) return NO;
    return [NSDate new].kb_day == self.kb_day;
}

- (BOOL)kb_isYesterday {
    return [[self kb_nextDate] kb_isToday];
}

- (BOOL)kb_isTomorrow {
    return [[self kb_lastDate] kb_isToday];
}

- (NSDate *)kb_dateByAddingYears:(NSInteger)years {
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)kb_dateByAddingMonths:(NSInteger)months {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)kb_dateByAddingWeeks:(NSInteger)weeks {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)kb_dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + kbDayTimeInterval * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)kb_dateByAddingHours:(NSInteger)hours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + kbHourTimeInterval * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)kb_dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + kbMinuteTimeInterval * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)kb_dateByAddingSeconds:(NSInteger)seconds {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)kb_nextDate {
    return [self kb_dateByAddingDays:1];
}

- (NSDate *)kb_lastDate {
    return [self kb_dateByAddingDays:-1];
}

+ (NSDate *)kb_yesterday {
    return [[NSDate date] kb_lastDate];
}

+ (NSDate *)kb_tomorrow {
    return [[NSDate date] kb_nextDate];;
}

+ (NSDate *)kb_dateFromString:(NSString *)string format:(NSString *)format {
    return [self kb_dateFromString:string format:format timeZone:nil locale:nil];
}

+ (NSDate *)kb_dateFromString:(NSString *)string format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [NSDateFormatter kb_dateFormatterWithformat:format timeZone:timeZone locale:locale];
    return [formatter dateFromString:string];
}

+ (NSDate *)kb_dateFromISOFormatString:(NSString *)string {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter kb_dateFormatterWithformat:ISODateFormat timeZone:nil locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    });
    return [formatter dateFromString:string];
}

- (NSString *)kb_stringWithFormat:(NSString *)format {
    return [self kb_stringWithFormat:format timeZone:nil locale:[NSLocale currentLocale]];
}

- (NSString *)kb_stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [NSDateFormatter kb_dateFormatterWithformat:format timeZone:timeZone locale:locale];
    return [formatter stringFromDate:self];
}

- (NSString *)kb_stringWithISOFormat {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter kb_dateFormatterWithformat:ISODateFormat timeZone:nil locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    });
    return [formatter stringFromDate:self];
}

+ (NSString *)kb_msStringFromSecondInterval:(NSInteger)secondInterval format:(NSString *)format {
    if (secondInterval<0) {
        return nil;
    }
    
    NSInteger minute = secondInterval / 60;//???
    NSInteger second = secondInterval % 60;//???
    NSString *minuteStr = minute < 10 ? [NSString stringWithFormat:@"0%@",@(minute)] : [NSString stringWithFormat:@"%@",@(minute)];
    NSString *secondStr = second < 10 ? [NSString stringWithFormat:@"0%@",@(second)] : [NSString stringWithFormat:@"%@",@(second)];
    if ([format isEqualToString:dateFormat12]) {
        return [NSString stringWithFormat:@"%@:%@",minuteStr,secondStr];
    } else if ([format isEqualToString:dateFormat13]) {
        return [NSString stringWithFormat:@"%@???%@???",minuteStr,secondStr];
    } else {
        return [NSString stringWithFormat:@"%ld",secondInterval];
    }
}

@end

@implementation NSDate (KBServer)

+ (NSString *)kb_stringWithSecondIntervalSince1970:(NSNumber *)secsNum format:(NSString *)format {
    if (!secsNum.kbValidate) {
        return nil;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[secsNum doubleValue]];
    NSDateFormatter *formatter = [NSDateFormatter kb_dateFormatterWithformat:format timeZone:nil locale:nil];
    return [formatter stringFromDate:date];
}

+ (NSString *)kb_stringWithMillisecondIntervalSince1970:(NSNumber *)mSecsNum format:(NSString *)format {
    if (!mSecsNum.kbValidate) {
        return nil;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[mSecsNum doubleValue]/1000.f];
    NSDateFormatter *formatter = [NSDateFormatter kb_dateFormatterWithformat:format timeZone:nil locale:nil];
    return [formatter stringFromDate:date];
}

+ (NSString *)kb_stringFromOriginalString:(NSString *)string originalFormat:(NSString *)originalFormat finalFormat:(NSString *)finalFormat {
    NSDate *originalDate = [self kb_dateFromString:string format:originalFormat];
    return [originalDate kb_stringWithFormat:finalFormat];
}

@end

@implementation NSDate (KBCalender)

- (NSInteger)kb_era {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitEra fromDate:self] era];
}

- (NSInteger)kb_year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)kb_month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)kb_day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)kb_hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)kb_minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)kb_second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)kb_nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)kb_weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)kb_weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)kb_weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)kb_weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)kb_yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)kb_quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)kb_isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)kb_isLeapYear {
    NSUInteger year = self.kb_year;
    return (year % 400 == 0) || (year % 100 == 0) || (year % 4 == 0);
}

- (NSString*)kb_weekdayText {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"?????????", @"?????????", @"?????????", @"?????????", @"?????????", @"?????????", @"?????????", nil];
    return [weekdays objectAtIndex:[self kb_weekday]];
}

@end


@implementation NSDate (KBPrivate)

#pragma mark --????????????????????????????????????????????????????????????

- (NSString *)kb_shortTimeText {
    if ([self kb_isToday]) {
        //??????
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"aHH:mm"];
        [dateFormat setAMSymbol:@"??????"];
        [dateFormat setPMSymbol:@"??????"];
        NSString *dateString = [dateFormat stringFromDate:self];
        return dateString;
    } else if ([self kb_isYesterday]) {
        return @"??????";
    } else if ([self kb_isTomorrow]) {
        return @"??????";
    }
    else if (fabs(self.timeIntervalSinceNow) < kbWeekTimeInterval) {
        // ?????????
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormat setDateFormat:@"ccc"];
        NSString *dateString = [dateFormat stringFromDate:self];
        return dateString;
    } else {
        if ([self kb_year] == [[NSDate date] kb_year]) {//??????
            return [self kb_stringWithFormat:dateFormat11];
        } else {// ?????????
            return [self kb_stringWithFormat:dateFormat2];
        }
    }
}

- (NSString *)kb_timeText {
    NSDate *date = self;
    
    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
    
    interval = -interval;
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"aHH:mm"];
    [dateFormat setAMSymbol:@"??????"];
    [dateFormat setPMSymbol:@"??????"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    if ([date kb_isToday])
    {
        // ???????????????
        return dateString;
    }
    else if ([date kb_isYesterday])
    {
        // ??????
        return [NSString stringWithFormat:@"?????? %@", dateString];
    }
    else if (interval < kbWeekTimeInterval)
    {
        // ????????????
        // ???????????????NSDateFormatter??????
        NSDateFormatter* weekFor = [[NSDateFormatter alloc] init];
        weekFor.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [weekFor setDateFormat:@"ccc"];
        NSString *weekStr = [weekFor stringFromDate:date];
        return [NSString stringWithFormat:@"%@ %@", weekStr, dateString];
    }
    else
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        
        if ([components year] == [today year])
        {
            // ??????
            NSDateFormatter *mdFor = [[NSDateFormatter alloc] init];
            [mdFor setDateFormat:@"MM-dd"];
            NSString *mdStr = [mdFor stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", mdStr, dateString];
        }
        else
        {
            // ??????
            NSDateFormatter *ymdFormat = [[NSDateFormatter alloc] init];
            [ymdFormat setDateFormat:@"yy-MM-dd"];
            NSString *ymdString = [ymdFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", ymdString, dateString];;
            
        }
    }
    return nil;
}


- (NSString*)kb_simpleTimeStringSinceNow {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.timeZone=[NSTimeZone systemTimeZone];
    dateFormatter.dateFormat=@"YYYY-MM-dd";
    NSString *dateStr = [dateFormatter stringFromDate:self];
    NSInteger seconds = [self timeIntervalSinceNow];
    if (seconds <= 0) {
        
        seconds = ABS(seconds);
        
        if (seconds<60) {
            return @"??????";
        }else if (seconds<60*60) {
            return [NSString stringWithFormat:@"%ld?????????",(long)(seconds/60)];
        }else if (seconds<60*60*24) {
            return [NSString stringWithFormat:@"%ld?????????",(long)(seconds/(60*60))];
        }else {
            return dateStr;
        }
    }else{
        if (seconds<60) {
            return [NSString stringWithFormat:@"%ld?????????",(long)seconds];
        }else if (seconds<60*60) {
            return [NSString stringWithFormat:@"%ld?????????",(long)(seconds/60)];
        }else if (seconds<60*60*24) {
            return [NSString stringWithFormat:@"%ld?????????",(long)(seconds/(60*60))];
        }else if (seconds<60*60*24*60) {
            return [NSString stringWithFormat:@"%ld??????",(long)(seconds/(60*60*24))];
        }else{
            return @"60??????";
        }
    }
    
    return dateStr;
}

@end
