//
//  UIColor+KBCustom.m
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import "UIColor+KBCustom.h"

@implementation UIColor (KBExtension)
+ (UIColor *)kbColorWithHex:(int)hex {
    return [UIColor kbColorWithHex:hex alpha:1.0];
}
+ (UIColor *)kbColorWithHex:(int)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}
+ (UIColor *)kbRandomColor {
    #ifdef DEBUG
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    #else
    return [UIColor clearColor];
    #endif
}
//获取16进制颜色的方法
+ (UIColor *)kbColorWithHexStr:(NSString *)hexColor {
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {
        return nil;
    }
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rs = [hexColor substringWithRange:range];
    range.location = 2;
    NSString *gs = [hexColor substringWithRange:range];
    range.location = 4;
    NSString *bs = [hexColor substringWithRange:range];
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rs] scanHexInt:&r];
    [[NSScanner scannerWithString:gs] scanHexInt:&g];
    [[NSScanner scannerWithString:bs] scanHexInt:&b];
    if ([hexColor length] == 8) {
        range.location = 6;
        NSString *as = [hexColor substringWithRange:range];
        [[NSScanner scannerWithString:as] scanHexInt:&a];
    } else {
        a = 255;
    }
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
}
+ (UIColor *)kbColorFromColor:(UIColor *)color1 toColor:(UIColor *)color2 progress:(CGFloat)progress {
    
    if (color1==nil || color2==nil) {
        return nil;
    }
    
    progress = fmaxf(0, fminf(progress, 1));
    
    CGFloat initialRed, initialGreen, initialBlue, initialAlpha;
    CGFloat finalRed, finalGreen, finalBlue, finalAlpha;
    
    [color1 getRed:&initialRed green:&initialGreen blue:&initialBlue alpha:&initialAlpha];
    [color2 getRed:&finalRed green:&finalGreen blue:&finalBlue alpha:&finalAlpha];
    
    CGFloat red = initialRed - (initialRed - finalRed) * progress;
    CGFloat green = initialGreen - (initialGreen - finalGreen) * progress;
    CGFloat blue = initialBlue - (initialBlue - finalBlue) * progress;
    CGFloat alpha = initialAlpha - (initialAlpha - finalAlpha) * progress;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
