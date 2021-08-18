//
//  UIButton+KB.m
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/9.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import "UIButton+KB.h"
#import "UIImage+KB.h"

@implementation UIButton (KB)
+ (instancetype)kb_buttonWithTarget:(id)target action:(SEL)action {
    return [self kb_buttonWithBackgroundColor:[UIColor clearColor] target:target action:action];
}
+ (instancetype)kb_buttonWithBackgroundColor:(UIColor *)backgroundColor target:(nullable id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)kb_setImageWithName:(NSString *)imageName forState:(UIControlState)state {
    [self setImage:kbImageWithName(imageName) forState:state];
}
- (void)kb_setBackgroundImageWithName:(NSString *)imageName forState:(UIControlState)state {
    [self setBackgroundImage:kbImageWithName(imageName) forState:state];
}
- (void)kb_setTitleFont:(UIFont *)font forState:(UIControlState)state {
    
}
- (void)kb_setNormalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}
@end
