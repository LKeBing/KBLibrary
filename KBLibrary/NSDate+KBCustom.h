//
//  NSDate+KBCustom.h
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (KBCustom)

/// 明天
+ (NSDate *)nextDate;

/// 昨天
+ (NSDate *)lastDate;

//返回星期几
- (NSString*)weekdayString;

//时间的简易名称
- (NSString*)simpleTimeStringSinceNow;

@end

NS_ASSUME_NONNULL_END
