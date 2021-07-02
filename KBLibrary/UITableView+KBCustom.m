//
//  UITableView+KBCustom.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "UITableView+KBCustom.h"

@implementation UITableView (KBCustom)
- (void)registerCellWithNibName:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}
- (void)registerCellWithClass:(Class)cla {
    [self registerClass:cla forCellReuseIdentifier:NSStringFromClass(cla)];
}
- (void)registerHeaderFooterWithClass:(Class)cla {
    [self registerClass:cla forHeaderFooterViewReuseIdentifier:NSStringFromClass(cla)];
}
- (void)registerHeaderFooterWithNibName:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forHeaderFooterViewReuseIdentifier:nibName];
}
@end
