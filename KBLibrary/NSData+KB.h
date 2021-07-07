//
//  NSData+KB.h
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KB)

/// 字节大小，单位：G，M，K，B
- (NSString *)kb_bytesSizeText;

@end

NS_ASSUME_NONNULL_END
