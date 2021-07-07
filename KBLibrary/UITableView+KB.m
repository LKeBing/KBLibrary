//
//  UITableView+KB.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "UITableView+KB.h"
#import "NSObject+KB.h"

@implementation UITableView (KB)
- (void)kb_registerCellWithNibName:(NSString *)nibName {
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}
- (void)kb_registerCellWithNibClass:(Class)cla {
    [self registerNib:[UINib nibWithNibName:cla.className bundle:nil] forCellReuseIdentifier:cla.className];
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
- (void)kb_registerHeaderFooterWithNibClass:(Class)cla {
    [self registerNib:[UINib nibWithNibName:cla.className bundle:nil] forHeaderFooterViewReuseIdentifier:cla.className];
}

@end
