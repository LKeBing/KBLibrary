//
//  UITableView+KB.h
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import <UIKit/UIKit.h>
#import "NSObject+KB.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (KB)

- (void)kb_registerNibCell:(NSString *)nibName identifier:(NSString *)identifier;
- (void)kb_registerNibHeaderFooter:(NSString *)nibName identifier:(NSString *)identifier;

- (void)kb_scrollToBottom:(NSTimeInterval)delay animated:(BOOL)animated;

@end

#define kb_tableView_register_cell(tableView, Cell)\
        [tableView registerClass:Cell.class forCellReuseIdentifier:Cell.kbClassName]

#define kb_tableView_register_nibCell(tableView, Nib)\
        [tableView kb_registerNibCell:Nib.kbClassName identifier:Nib.kbClassName]

#define kb_tableView_reuse_cell(tableView, Cell)\
        [tableView dequeueReusableCellWithIdentifier:Cell.kbClassName]

#define kb_tableView_register_headerFooter(tableView, HeaderFooterView)\
        [tableView registerClass:HeaderFooterView.class forHeaderFooterViewReuseIdentifier:HeaderFooterView.kbClassName]

#define kb_tableView_register_nibHeaderFooter(tableView, Nib)\
        [tableView kb_registerNibHeaderFooter:Nib.kbClassName identifier:Nib.kbClassName]

#define kb_tableView_reuse_headerFooter(tableView, HeaderFooterView)\
        [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderFooterView.kbClassName]

NS_ASSUME_NONNULL_END
