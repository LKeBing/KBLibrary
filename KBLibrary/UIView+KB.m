//
//  UIView+KB.m
//  KBLibrary
//
//  Created by SXJY on 2021/4/16.
//

#import "UIView+KB.h"
#import "KBTool.h"
#import "NSArray+KB.h"

@implementation UIView (KB)

- (UIWindow *)kbKeyWindow {
    if (self.window) {
        return self.window;
    } else {
        return [KBTool keyWindow];
    }
}

- (UIViewController *)kbContainerViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)kb_removeSubviews {
    [self.subviews kb_removeFromSuperview];
}


/// 此方法暂未对外开放
- (void)setGradientColor {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.bounds;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 0);
    gl.colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.35].CGColor];
    gl.locations = @[@(0),@(0.7), @(1.0f)];
    [self.layer addSublayer:gl];
}

@end

@implementation UIView (KBLayer)

- (void)setKbCornerRadius:(CGFloat)kbCornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = kbCornerRadius;
}
- (CGFloat)kbCornerRadius {
    return self.layer.cornerRadius;
}
- (void)setKbShadowColor:(UIColor *)kbShadowColor {
    self.layer.masksToBounds = YES;
    self.layer.shadowColor = kbShadowColor.CGColor;
}
- (UIColor *)kbShadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
- (void)setKbShadowOffset:(CGSize)kbShadowOffset {
    self.layer.masksToBounds = YES;
    self.layer.shadowOffset = kbShadowOffset;
}
- (CGSize)kbShadowOffset {
    return self.layer.shadowOffset;
}
- (void)setKbShadowOpacity:(CGFloat)kbShadowOpacity {
    self.layer.masksToBounds = YES;
    self.layer.shadowOpacity = kbShadowOpacity;
}
- (CGFloat)kbShadowOpacity {
    return self.layer.shadowOpacity;
}

@end
