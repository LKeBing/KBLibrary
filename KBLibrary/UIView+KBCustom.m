//
//  UIView+KBCustom.m
//  KBLibrary
//
//  Created by SXJY on 2021/4/16.
//

#import "UIView+KBCustom.h"
#import "KBTool.h"

@implementation UIView (KBExtension)

-(UIWindow *)kbKeyWindow
{
    if (self.window)
    {
        return self.window;
    }
    else
    {
        return [KBTool keyWindow];
    }
}

- (UIViewController *)containerViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:cornerRadius];
}
- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;;
}

@end
