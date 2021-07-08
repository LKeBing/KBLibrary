//
//  UIViewController+KB.h
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KB)
- (void)kb_pushViewController:(UIViewController *)vc;
- (void)kb_pushViewController:(UIViewController *)vc animated:(BOOL)animated;
- (void)kb_presentViewController:(UIViewController *)vc;
- (void)kb_presentViewController:(UIViewController *)vc animated: (BOOL)animated;
- (void)kb_back;
@end

NS_ASSUME_NONNULL_END
