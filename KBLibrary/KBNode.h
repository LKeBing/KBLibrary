//
//  KBNode.h
//  KBLibrary_Example
//
//  Created by SXJY on 2021/11/16.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface KBNode : NSObject

/**
 标题
 */
KBFloatProperty title;

/**
 详细描述
 */
KBFloatProperty detail;

/**
 唯一标识
 */
KBFloatProperty identifier;


/**
 view高度
 */
KBFloatProperty viewHeight;

@end

NS_ASSUME_NONNULL_END
