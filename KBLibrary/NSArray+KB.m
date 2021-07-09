//
//  NSArray+KB.m
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/9.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import "NSArray+KB.h"

@implementation NSArray (KB)

@end

@implementation NSArray (KBViews)

- (void)kb_removeFromSuperview {
    if ([self isKindOfClass:[NSArray<UIView *> class]]) {
        [self makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}

@end
