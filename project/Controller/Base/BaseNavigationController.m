//
//  BaseNavigationController.m
//  ShanjianUser
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.navigationBar.translucent) {
        self.navigationBar.translucent = NO;
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationBar.tintColor = kBlackFontColor;
        self.navigationBar.titleTextAttributes = @{
                                                   NSForegroundColorAttributeName: UIColorHex(333333),
                                                   NSFontAttributeName: [UIFont boldSystemFontOfSize:18]
                                                   };
    }
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];

    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    @weakify(self)
    [super dismissViewControllerAnimated:flag completion:^{
        @strongify(self)
        BLOCK_EXEC(completion)
        BLOCK_EXEC(self.dismissBlock)
    }];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count > 1;
}

@end
