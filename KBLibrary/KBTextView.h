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

/**
 Set textView's placeholder text. Default is nil.
 */
@property(nullable, nonatomic,copy) IBInspectable NSString    *placeholder;

/**
 Set textView's placeholder attributed text. Default is nil.
 */
@property(nullable, nonatomic,copy) IBInspectable NSAttributedString    *attributedPlaceholder;

/**
 To set textView's placeholder text color. Default is nil.
 */
@property(nullable, nonatomic,copy) IBInspectable UIColor    *placeholderTextColor;

KBIntProperty maxCharCount;//最大字符个数限制，默认为0，即不做限制

@end

NS_ASSUME_NONNULL_END
