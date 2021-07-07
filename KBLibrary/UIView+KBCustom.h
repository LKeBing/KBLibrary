//
//  UIView+KBCustom.h
//  KBLibrary
//
//  Created by SXJY on 2021/4/16.
//

#import <UIKit/UIKit.h>
#import "KBProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KBExtension)
KBStrongPropertyWithClass(UIWindow) kbKeyWindow;
KBStrongPropertyWithClass(UIViewController) kbContainerViewController;
KBFloatProperty kbCornerRadius;
@end

NS_ASSUME_NONNULL_END
