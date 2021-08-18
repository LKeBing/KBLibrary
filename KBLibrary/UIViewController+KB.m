//
//  UIViewController+KB.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "UIViewController+KB.h"

@implementation UIViewController (KB)
- (void)kb_back {
    if (self.navigationController.viewControllers.count == 1) {
        if (self.navigationController.parentViewController) {
            
        } else {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    } else if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
                    
        }];
    }
}

- (void)kb_pushViewController:(UIViewController *)vc {
    [self kb_pushViewController:vc animated:YES];
}
- (void)kb_pushViewController:(UIViewController *)vc animated:(BOOL)animated {
    [self.navigationController pushViewController:vc animated:animated];
}
- (void)kb_presentViewController:(UIViewController *)vc {
    [self kb_presentViewController:vc animated:YES];
}
- (void)kb_presentViewController:(UIViewController *)vc animated:(BOOL)animated {
    [self presentViewController:vc animated:animated completion:nil];
}

- (void)kb_removeChildrenViewControllers {
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
}

@end
