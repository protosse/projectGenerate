//
//  MainTabBarController.m
//  BaseProject_oc
//
//  Created by liuliu on 2021/4/25.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "ViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    CYLTabBarController *t = [CYLTabBarController tabBarControllerWithViewControllers:[self viewControllers]
            tabBarItemsAttributes:[self tabBarItemsAttributes]];
    return (self = (MainTabBarController *) t);
}

- (NSArray *)viewControllers {
    return @[
            [[BaseNavigationController alloc] initWithRootViewController:[ViewController new]],
    ];
}

- (NSArray *)tabBarItemsAttributes {
    return @[
            @{
                    CYLTabBarItemTitle: @"Home"
            },
    ];
}

@end
