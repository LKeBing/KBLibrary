//
//  UIColor+KB.h
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kbRGBAColor(red, green, blue, alpha)\
        [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha]

#define kbRGBColor(red, green, blue)\
        kbRGBAColor(red, green, blue, 1.f)

#define kbColorWithRGBAHex(rgbHex, alpha)\
        kbColorWithRGB((float)((rgbHex & 0xFF0000) >> 16), ((float)((rgbHex & 0x00FF00) >> 8)), ((float)(rgbHex & 0x0000FF)), alpha)

#define kbColorWithRGBHex(rgbHex)\
        kbColorWithRGBAHex(rgbHex, 1.0)

#define kbRandomColor\
        [UIColor kb_randomColor]

@interface UIColor (KB)

/// 采用16进制数字创建颜色color，透明值默认1.
/// @param hex 16进制数字
+ (UIColor *)kb_colorWithHex:(int)hex;

/// 采用16进制数字创建颜色color
/// @param hex 16进制数字
/// @param alpha 颜色透明度
+ (UIColor *)kb_colorWithHex:(int)hex alpha:(CGFloat)alpha;

/// 采用16进制字符串创建颜色color，透明值可能包含在字符串中--最后两位
/// @param hexStr 16进制字符串
+ (UIColor *)kb_colorWithHexStr:(NSString *)hexStr;

/// 随机颜色
+ (UIColor *)kb_randomColor;

/// 颜色从color1过渡到color2，根据progress得到中间的一个新颜色
/// @param color1 起始颜色
/// @param color2 终点颜色
/// @param progress 过渡进程比率
+ (UIColor *)kb_colorFromColor:(UIColor *)color1 toColor:(UIColor *)color2 progress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
