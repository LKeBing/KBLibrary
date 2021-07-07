//
//  UIImageView+KB.m
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/7.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import "UIImageView+KB.h"
#import "UIImage+KB.h"

@implementation UIImageView (KB)
- (void)kb_setImageWithName:(NSString *)imageName {
    self.image = kbImageWithName(imageName);
}
@end
