//
//  UIView+KB.m
//  KBLibrary
//
//  Created by SXJY on 2021/4/16.
//

#import "UIView+KB.h"
#import "KBTool.h"

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

- (void)setKbCornerRadius:(CGFloat)kbCornerRadius {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:kbCornerRadius];
}
- (CGFloat)kbCornerRadius {
    return self.layer.cornerRadius;;
}

@end
