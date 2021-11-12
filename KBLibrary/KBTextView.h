//
//  KBTextView.h
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/21.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface KBTextView : UITextView

KBStringProperty placeholder;
KBColorProperty placeholderColor;

KBAttributedStringProperty attributedPlaceholder;

- (void)clearAllMargin;//清除四周的间隙

@end

NS_ASSUME_NONNULL_END
