//
//  UIImageView+KB.h
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/7.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (KB)
+ (instancetype)kb_imageViewWithImageName:(NSString *)name;
- (void)kb_setImageWithName:(NSString *)name;
- (void)kb_setImageWithUrl:(NSString *)url;
- (void)kb_setImageWithUrl:(NSString *)url placeholderName:(NSString *_Nullable)placeholderName;
- (void)kb_setImageWithUrl:(NSString *)url placeholderName:(NSString *_Nullable)placeholderName completed:(void (^_Nullable)(UIImage *_Nullable))completion;
- (void)kb_clearImage;
@end

NS_ASSUME_NONNULL_END
