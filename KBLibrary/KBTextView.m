//
//  KBTextView.m
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/21.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import "KBTextView.h"

@interface KBTextView ()

KBLabelProperty placeholderLabel;

@end

@implementation KBTextView

@synthesize placeholder = _placeholder;
@synthesize placeholderLabel = _placeholderLabel;
@synthesize placeholderColor = _placeholderColor;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _placeholderLabel.frame = [self placeholderExpectedFrame];
}

-(void)dealloc
{
    [_placeholderLabel removeFromSuperview];
    _placeholderLabel = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// 监听textView内容变化
-(void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlaceholderHidden) name:UITextViewTextDidChangeNotification object:self];
}

//当textField里的文本改变时, 该delegate的getter方法会被调用. 此时就刷新一下textView的placeholder
-(id<UITextViewDelegate>)delegate
{
    [self refreshPlaceholderHidden];
    
    return [super delegate];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self refreshPlaceholderHidden];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self refreshPlaceholderHidden];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    _placeholderLabel.font = self.font;
    [self refreshPlaceholderFrame];
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    
    _placeholderLabel.textAlignment = textAlignment;
}




-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    [self refreshPlaceholderFrame];
}

-(void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    _attributedPlaceholder = attributedPlaceholder;
    
    self.placeholderLabel.attributedText = attributedPlaceholder;
    [self refreshPlaceholderFrame];
}

-(void)setplaceholderColor:(UIColor*)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    _placeholderLabel.textColor = placeholderColor;
}




-(UILabel*)placeholderLabel
{
    if (_placeholderLabel == nil)
    {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.font = self.font;
        _placeholderLabel.textAlignment = self.textAlignment;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
        if (@available(iOS 13.0, *)) {
            _placeholderLabel.textColor = [UIColor systemGrayColor];
        } else
#endif
        {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
            _placeholderLabel.textColor = [UIColor lightTextColor];
#endif
        }
        if (_placeholderColor) {
            _placeholderLabel.textColor = _placeholderColor;
        }
        [self addSubview:_placeholderLabel];
    }
    
    return _placeholderLabel;
}

-(void)refreshPlaceholderHidden
{
    _placeholderLabel.hidden = [[self text] length]>0 || [[self attributedText] length]>0;
}

-(void)refreshPlaceholderFrame
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(UIEdgeInsets)placeholderInsets
{
    return UIEdgeInsetsMake(self.textContainerInset.top, self.textContainerInset.left + self.textContainer.lineFragmentPadding, self.textContainerInset.bottom, self.textContainerInset.right + self.textContainer.lineFragmentPadding);
}

-(CGRect)placeholderExpectedFrame
{
    UIEdgeInsets placeholderInsets = [self placeholderInsets];
    CGFloat maxWidth = CGRectGetWidth(self.frame)-placeholderInsets.left-placeholderInsets.right;
    
    CGSize expectedSize = [_placeholderLabel sizeThatFits:CGSizeMake(maxWidth, CGRectGetHeight(self.frame)-placeholderInsets.top-placeholderInsets.bottom)];
    
    return CGRectMake(placeholderInsets.left, placeholderInsets.top, maxWidth, expectedSize.height);
}



- (void)clearAllMargin {
    self.textContainer.lineFragmentPadding = 0.0;
    self.textContainerInset = UIEdgeInsetsZero;
    
    [self refreshPlaceholderFrame];
}

@end
