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
#define KBLog(FORMAT, ...) fprintf(stderr,"%s:%d \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define KBLog(FORMAT, ...) nil
#endif

// 设备屏幕尺寸 （逻辑分辨率）
#define     kbScreenWidth       [UIScreen mainScreen].bounds.size.width
#define     kbScreenHeight      [UIScreen mainScreen].bounds.size.height

#define kbSharedApplication     [UIApplication sharedApplication]
#define kbAppDelegate           ((AppDelegate *)kbSharedApplication.delegate)

// 沙盒路径
#define kbSandboxPath           NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES).lastObject

#define kbUserDefaults          [NSUserDefaults standardUserDefaults]
#define kbNotificationCenter    [NSNotificationCenter defaultCenter]

#define kb_post_notification(name) [kbNotificationCenter postNotificationName:name object:nil]//发布一个建议通知，不传任何值

#define kb_keep_screen_light        kbSharedApplication.idleTimerDisabled = YES;//保持屏幕常亮
#define kb_cancel_keep_screen_light kbSharedApplication.idleTimerDisabled = NO;//取消屏幕常亮

#define kb_new_arr      @[]
#define kb_new_muArr    @[].mutableCopy
#define kb_new_dic      @{}
#define kb_new_muDic    @{}.mutableCopy

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


#define kb_string_to_string(string)     [NSString stringWithFormat:@"%@",string]
#define kb_number_to_string(number)     [NSString stringWithFormat:@"%@",number]
#define kb_integer_to_string(integer)   kb_number_to_string(@(integer))
#define kb_float_to_string(float)       kb_number_to_string(@(float))

#endif /* KBMacroDefinition_h */
