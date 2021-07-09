//
//  UIImageView+KB.m
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/7.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import "UIImageView+KB.h"
#import "UIImage+KB.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (KB)
+ (instancetype)kb_imageViewWithImageName:(NSString *)name {
    UIImageView *imageView = [UIImageView new];
    [imageView kb_setImageWithName:name];
    return imageView;
}
- (void)kb_setImageWithName:(NSString *)name {
    self.image = kbImageWithName(name);
}
- (void)kb_setImageWithUrl:(NSString *)url {
    [self kb_setImageWithUrl:url placeholderName:nil];
}
- (void)kb_setImageWithUrl:(NSString *)url placeholderName:(NSString * _Nullable)placeholderName {
    [self kb_setImageWithUrl:url placeholderName:placeholderName completed:nil];
}
- (void)kb_setImageWithUrl:(NSString *)url placeholderName:(NSString * _Nullable)placeholderName completed:(void (^ _Nullable)(UIImage * _Nullable))completion {
    if (![url kbValidate]) {
        if (completion) {
            completion(nil);
        }
        return;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kbImageWithName(placeholderName) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (completion) {
            completion(image);
        }
    }];
}
- (void)kb_clearImage {
    self.image = nil;
}
@end
