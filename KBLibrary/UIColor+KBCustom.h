//
//  UIColor+KBCustom.h
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define KB_RGB_COLOR(Red, Green, Blue, Alpha) [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]
#define KB_Hex_Color(hex) [UIColor kbColorWithHex:hex]

@interface UIColor (KBExtension)
+ (UIColor *)kbRandomColor;
+ (UIColor *)kbColorWithHex:(int)hex;
+ (UIColor *)kbColorWithHex:(int)hex alpha:(CGFloat)alpha;
+ (UIColor *)kbColorWithHexStr:(NSString *)hexStr;
+ (UIColor *)kbColorFromColor:(UIColor *)color1 toColor:(UIColor *)color2 progress:(CGFloat)progress;
@end

NS_ASSUME_NONNULL_END
