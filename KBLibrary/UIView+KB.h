//
//  UIView+KB.h
//  KBLibrary
//
//  Created by SXJY on 2021/4/16.
//

#import <UIKit/UIKit.h>
#import "KBProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KB)

/// 获取keyWindow
KBStrongReadPropertyWithClass(UIWindow) kbKeyWindow;

/// 包含当前view的viewController
KBStrongReadPropertyWithClass(UIViewController) kbContainerViewController;

- (void)kb_removeSubviews;

@end

@interface UIView (KBLayer)
KBFloatProperty kbCornerRadius;
KBColorProperty kbShadowColor;
KBSizeProperty kbShadowOffset;
KBFloatProperty kbShadowOpacity;
@end

NS_ASSUME_NONNULL_END
