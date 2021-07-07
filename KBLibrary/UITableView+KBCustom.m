//
//  UITableView+KBCustom.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "UITableView+KBCustom.h"

@implementation UITableView (KBCustom)
- (void)kb_registerCellWithNibName:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}
- (void)kb_registerCellWithClass:(Class)cla {
    [self registerClass:cla forCellReuseIdentifier:NSStringFromClass(cla)];
}
- (void)kb_registerHeaderFooterWithClass:(Class)cla {
    [self registerClass:cla forHeaderFooterViewReuseIdentifier:NSStringFromClass(cla)];
}
- (void)kb_registerHeaderFooterWithNibName:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forHeaderFooterViewReuseIdentifier:nibName];
}
@end
