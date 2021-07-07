//
//  UITableView+KB.h
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (KB)
- (void)kb_registerCellWithNibName:(NSString *)nibName;
- (void)kb_registerCellWithNibClass:(Class)cla;
- (void)kb_registerCellWithClass:(Class)cla;
- (void)kb_registerHeaderFooterWithNibName:(NSString *)nibName;
- (void)kb_registerHeaderFooterWithClass:(Class)cla;
- (void)kb_registerHeaderFooterWithNibClass:(Class)cla;
@end

NS_ASSUME_NONNULL_END
