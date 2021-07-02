//
//  UITableView+KBCustom.h
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (KBCustom)
- (void)registerCellWithNibName:(NSString *)nibName;
- (void)registerCellWithClass:(Class)cla;
- (void)registerHeaderFooterWithNibName:(NSString *)nibName;
- (void)registerHeaderFooterWithClass:(Class)cla;
@end

NS_ASSUME_NONNULL_END
