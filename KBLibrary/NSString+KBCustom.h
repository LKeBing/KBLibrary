//
//  NSString+KBCustom.h
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KBCustom)
- (NSString *)stringWithoutWhitespaceAndNewline;
//取出字符串中的十进制数字
- (NSString *)decimalDigitCharacters;

- (NSString *)urlEncodeString;
- (NSString *)urlDecodeString;

@end

NS_ASSUME_NONNULL_END
