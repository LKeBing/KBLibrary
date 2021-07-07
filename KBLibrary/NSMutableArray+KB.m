//
//  NSMutableArray+KB.m
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/7.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import "NSMutableArray+KB.h"

@implementation NSMutableArray (KB)

- (void)kb_reverse {
  NSUInteger i = 0;
  NSUInteger j = [self count] - 1;
  while (i < j) {
    [self exchangeObjectAtIndex:i withObjectAtIndex:j];
    i++;
    j--;
  }
}

@end
