//
//  KBTranslucentViewController.h
//  SXT
//
//  Created by SXJY on 2021/6/23.
//  Copyright © 2021 KeBing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface KBTranslucentViewController : UIViewController
KBFloatProperty alpha;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
