//
//  NSData+KB.m
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import "NSData+KB.h"

@implementation NSData (KB)

- (NSString *)kb_bytesSizeText {
    NSInteger size = self.length;
    if (size > powf(2, 3*10)) {
        return  [NSString stringWithFormat:@"%0.1fG",(float)size/powf(2, 3*10)];
    }else if (size > powf(2, 2*10)) {
        return  [NSString stringWithFormat:@"%0.1fM",(float)size/powf(2, 2*10)];
    }else if (size > powf(2, 10)){
        return  [NSString stringWithFormat:@"%0.1fK",(float)size/powf(2, 10)];
    }else{
        return  [NSString stringWithFormat:@"%ziB",size];
    }
}

@end
