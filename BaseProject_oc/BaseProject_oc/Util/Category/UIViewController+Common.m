//
//  UIViewController+Common.m
//  BaseProject_oc
//
//  Created by doom on 2018/7/28.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

+ (UIViewController *)currentViewController {
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    return [self topViewControllerForViewController:rootViewController];
}

+ (UIViewController *)topViewControllerForViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *) rootViewController;
        return [self topViewControllerForViewController:navigationController.visibleViewController];
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *) rootViewController;
        return [self topViewControllerForViewController:tabBarController.selectedViewController];
    } else if (rootViewController.presentedViewController) {
        return [self topViewControllerForViewController:rootViewController.presentedViewController];
    }

    return rootViewController;
}

@end
