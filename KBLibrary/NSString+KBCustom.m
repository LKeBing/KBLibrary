//
//  NSString+KBCustom.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "NSString+KBCustom.h"

@implementation NSString (KBCustom)

- (NSString *)kb_withoutWhitespaceAndNewline  {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString *)kb_decimalDigitCharacters {
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return[[self componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}

@end

@implementation NSString (KBUrl)

// urlencode
- (NSString *)kb_encodeUrl {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
// urldecode
- (NSString *)kb_decodeUrl {
    return [self stringByRemovingPercentEncoding];
}

@end
