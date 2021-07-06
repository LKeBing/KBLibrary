//
//  KBMacroDefine.h
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import <UIKit/UIKit.h>

#ifndef KBMacroDefinition_h
#define KBMacroDefinition_h

//打印
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

// 设备屏幕尺寸 （逻辑分辨率）
#define     kbScreenWidth                [UIScreen mainScreen].bounds.size.width
#define     kbScreenHeight               [UIScreen mainScreen].bounds.size.height

#define kbSharedApplication     [UIApplication sharedApplication]
#define kbDelegate              ((AppDelegate *)kbSharedApplication.delegate)

// 沙盒路径
#define kbSandboxPath           NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES).lastObject

#define kbUserDefaults          [NSUserDefaults standardUserDefaults]
#define kbNotificationCenter    [NSNotificationCenter defaultCenter]
//是否是横屏
#define kbScreenIsLandscape     kbSharedApplication.statusBarOrientation >= 3

//系统版本号
#define KB_IOS_VERSION          [[[UIDevice currentDevice] systemVersion] floatValue]
//APP版本号
#define KB_APP_VERSION          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//APP名字
#define KB_APP_NAME             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//APP构建版本号
#define KB_APP_BUILD_VERSION    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#endif /* KBMacroDefinition_h */
