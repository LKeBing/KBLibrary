//
//  KBTool.h
//  KBLibrary
//
//  Created by SXJY on 2021/6/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/***/
@interface KBTool : NSObject

+ (NSData *)compressImageData:(UIImage *)sourceImage toByte:(NSInteger)maxSize;
+ (NSData *)compressImage:(NSData *)sourceImageData toByte:(NSInteger)maxSize;

+ (UIImage *)getVideoThumbImageWithUrl:(NSString *)videoUrl;
+ (UIImage *)getVideoThumbImageWithURL:(NSURL *)videoURL; //获取视频缩略图

/**验证身份证号码*/
+ (BOOL)validateIDCardNumber:(NSString *)value;

///创建文件夹
+(void)createDirectoryAtPath:(NSString *)path;

//四舍五入保留多少位小数
+ (CGFloat)roundDecimal:(CGFloat)decimal count:(NSInteger)count;
//四舍五入保留1位小数
+ (CGFloat)roundTo1Decimal:(CGFloat)decimal;
//四舍五入保留2位小数
+ (CGFloat)roundTo2Decimal:(CGFloat)decimal;

+ (UIWindow *)keyWindow;
+ (CGFloat)statusBarHeight;

@end

NS_ASSUME_NONNULL_END
