//
//  UIButton+KB.h
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/9.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KB)
+ (instancetype)kb_buttonWithTarget:(id)target action:(SEL)action;
- (void)kb_setImageWithName:(nullable NSString *)imageName forState:(UIControlState)state;
- (void)kb_setBackgroundImageWithName:(nullable NSString *)imageName forState:(UIControlState)state;
- (void)kb_setTitleFont:(nullable UIFont *)font forState:(UIControlState)state;
@end

NS_ASSUME_NONNULL_END
