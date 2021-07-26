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
KBLabelProperty charCountLabel;

@end

@implementation KBTextView

@synthesize placeholder = _placeholder;
@synthesize placeholderLabel = _placeholderLabel;
@synthesize placeholderTextColor = _placeholderTextColor;

-(void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlaceholder) name:UITextViewTextDidChangeNotification object:self];
}

-(void)dealloc
{
    [_placeholderLabel removeFromSuperview];
    _placeholderLabel = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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

-(void)refreshPlaceholder
{
    if([[self text] length] || [[self attributedText] length])
    {
        [self.placeholderLabel setAlpha:0];
    }
    else
    {
        [self.placeholderLabel setAlpha:1];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self refreshPlaceholder];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self refreshPlaceholder];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = self.font;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    self.placeholderLabel.textAlignment = textAlignment;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.frame = [self placeholderExpectedFrame];
    
    if (_charCountLabel) {
        _charCountLabel.frame = [self charCountExpectedFrame];
        
    }
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    [self refreshPlaceholder];
}

-(void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    _attributedPlaceholder = attributedPlaceholder;
    
    self.placeholderLabel.attributedText = attributedPlaceholder;
    [self refreshPlaceholder];
}

-(void)setPlaceholderTextColor:(UIColor*)placeholderTextColor
{
    _placeholderTextColor = placeholderTextColor;
    self.placeholderLabel.textColor = placeholderTextColor;
}

-(UIEdgeInsets)placeholderInsets
{
    return UIEdgeInsetsMake(self.textContainerInset.top, self.textContainerInset.left + self.textContainer.lineFragmentPadding, self.textContainerInset.bottom, self.textContainerInset.right + self.textContainer.lineFragmentPadding);
}

-(CGRect)placeholderExpectedFrame
{
    UIEdgeInsets placeholderInsets = [self placeholderInsets];
    CGFloat maxWidth = CGRectGetWidth(self.frame)-placeholderInsets.left-placeholderInsets.right;
    
    CGSize expectedSize = [self.placeholderLabel sizeThatFits:CGSizeMake(maxWidth, CGRectGetHeight(self.frame)-placeholderInsets.top-placeholderInsets.bottom)];
    
    return CGRectMake(placeholderInsets.left, placeholderInsets.top, maxWidth, expectedSize.height);
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
        _placeholderLabel.alpha = 0;
        [self addSubview:_placeholderLabel];
    }
    
    return _placeholderLabel;
}


//When any text changes on textField, the delegate getter is called. At this time we refresh the textView's placeholder
-(id<UITextViewDelegate>)delegate
{
    [self refreshPlaceholder];
    return [super delegate];
}

-(CGSize)intrinsicContentSize
{
    if (self.hasText) {
        return [super intrinsicContentSize];
    }
    
    UIEdgeInsets placeholderInsets = [self placeholderInsets];
    CGSize newSize = [super intrinsicContentSize];
    
    newSize.height = [self placeholderExpectedFrame].size.height + placeholderInsets.top + placeholderInsets.bottom;
    
    return newSize;
}




-(UILabel*)charCountLabel
{
    if (_charCountLabel == nil)
    {
        _charCountLabel = [[UILabel alloc] init];
        _charCountLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin);
        _charCountLabel.font = self.font;
        _charCountLabel.textAlignment = NSTextAlignmentRight;
        _charCountLabel.backgroundColor = [UIColor redColor];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
        if (@available(iOS 13.0, *)) {
            _charCountLabel.textColor = [UIColor systemGrayColor];
        } else
#endif
        {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
            _charCountLabel.textColor = [UIColor lightTextColor];
#endif
        }
        [self addSubview:_charCountLabel];
    }
    
    return _charCountLabel;
}
- (void)setMaxCharCount:(int)maxCharCount {
    _maxCharCount = maxCharCount;
    
    if (_maxCharCount>0) {
        UIEdgeInsets insets = self.textContainerInset;
        insets.bottom += 20;
        self.textContainerInset = insets;
        
        self.charCountLabel.text = [NSString stringWithFormat:@"0/%d",_maxCharCount];
    } else {
        [_charCountLabel removeFromSuperview];
        _charCountLabel = nil;
    }
}
-(UIEdgeInsets)charCountInsets
{
    return UIEdgeInsetsMake(self.textContainerInset.top, self.textContainerInset.left + self.textContainer.lineFragmentPadding, self.textContainerInset.bottom, self.textContainerInset.right + self.textContainer.lineFragmentPadding);
}

-(CGRect)charCountExpectedFrame
{
    UIEdgeInsets charCountInsets = [self charCountInsets];
    CGFloat maxWidth = CGRectGetWidth(self.frame)-charCountInsets.left-charCountInsets.right;
    
    CGSize expectedSize = [self.charCountLabel sizeThatFits:CGSizeMake(maxWidth, CGRectGetHeight(self.frame)-charCountInsets.top-charCountInsets.bottom)];
    
    return CGRectMake(charCountInsets.left, CGRectGetHeight(self.frame)-expectedSize.height, maxWidth, 20);
}


@end
