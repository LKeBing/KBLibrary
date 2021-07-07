//
//  UIViewController+KBCustom.m
//  Homework
//
//  Created by SXJY on 2021/6/28.
//

#import "UIViewController+KBCustom.h"

@implementation UIViewController (KBCustom)
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
