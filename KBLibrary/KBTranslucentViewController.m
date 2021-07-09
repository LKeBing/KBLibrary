//
//  KBTranslucentViewController.m
//  SXT
//
//  Created by SXJY on 2021/6/23.
//  Copyright © 2021 KeBing. All rights reserved.
//

#import "KBTranslucentViewController.h"

@interface KBTranslucentViewController ()<UIGestureRecognizerDelegate>

@end

@implementation KBTranslucentViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.alpha = 0.4;
    
    [self addDismissGes];
}

- (void)setAlpha:(CGFloat)alpha {
    _alpha = alpha;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:alpha];
}



#pragma mark -- 点击半透明背景区域收回弹窗

- (void)addDismissGes {
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapGes.delegate = self;
    [self.view addGestureRecognizer:tapGes];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [touch.view isEqual:self.view];
}
- (void)dismiss {
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}




#pragma mark -- 禁止转屏

// 开启自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}
// 只支持竖屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait; // 或者其他值 balabala~
}
- (void)setInterfaceOrientation:(UIDeviceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:orientation] forKey:@"orientation"];
    }
}

@end
