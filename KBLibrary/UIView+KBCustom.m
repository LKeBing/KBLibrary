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
- (void)setKbKeyWindow:(UIWindow *)kbKeyWindow {}

- (UIViewController *)kbContainerViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (void)setKbContainerViewController:(UIViewController *)kbContainerViewController {}

- (void)setKbCornerRadius:(CGFloat)kbCornerRadius {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:kbCornerRadius];
}
- (CGFloat)kbCornerRadius {
    return self.layer.cornerRadius;;
}

@end
