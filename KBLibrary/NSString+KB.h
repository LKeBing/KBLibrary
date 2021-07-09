//
//  NSString+KB.h
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KB)

/// 去掉字符串中的空格和换行
- (NSString *)kb_withoutWhitespaceAndNewline;

/// 取出字符串中的十进制数字
- (NSString *)kb_decimalDigitCharacters;

@end

@interface NSString (KBUrl)

/// 将url中的普通字符转为百分比编码字符，例如：“浙江省”转码后即变成了“%E6%B5%99%E6%B1%9F%E7%9C%81”
/// 若是链接中包含中文、特殊符号&％或是空格等都需要预先进行一下转码才可正常访问
- (NSString *)kb_urlEncode;

/// url解码
- (NSString *)kb_urlDecode;

@end

NS_ASSUME_NONNULL_END
