//
//  UITableView+KB.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "UITableView+KB.h"

@implementation UITableView (KB)

- (void)kb_registerNibCell:(NSString *)nibName identifier:(NSString *)identifier {
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:identifier];
}
- (void)kb_registerNibHeaderFooter:(NSString *)nibName identifier:(NSString *)identifier {
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];    
}

- (void)kb_scrollToBottom:(NSTimeInterval)delay animated:(BOOL)animated {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger s = [self numberOfSections]; //有多少组
        if (s<1) return;
        NSInteger r = [self numberOfRowsInSection:s-1]; //最后一组有多少行
        if (r<1) return;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:r-1 inSection:s-1]; //取最后一行数据
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
    });
}

@end
