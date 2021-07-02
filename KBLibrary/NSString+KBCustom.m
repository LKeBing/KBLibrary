//
//  NSString+KBCustom.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "NSString+KBCustom.h"

@implementation NSString (KBCustom)

- (NSString *)stringWithoutWhitespaceAndNewline  {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString *)decimalDigitCharacters {
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return[[self componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}

// urlencode
- (NSString *)urlEncodeString {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!$&'()*+,-./:;=?@_~%#[]"]];
}
// urldecode
- (NSString *)urlDecodeString {
    return [self stringByRemovingPercentEncoding];
}

@end
