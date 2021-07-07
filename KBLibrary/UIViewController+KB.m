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
@end
