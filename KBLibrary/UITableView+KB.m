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

@end
