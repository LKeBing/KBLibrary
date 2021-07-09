//
//  NSString+KB.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "NSString+KB.h"
#import "NSObject+KB.h"

@implementation NSString (KB)

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
- (NSString *)kb_urlEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}
// urldecode
- (NSString *)kb_urlDecode {
    return [self stringByRemovingPercentEncoding];
}

@end

