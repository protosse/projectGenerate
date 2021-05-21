//
//  AppDelegate.m
//  BaseProject_oc
//
//  Created by liuliu on 2021/4/25.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shared {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    return appDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self injection];
    [self customAppearance];

    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [MainTabBarController new];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)customAppearance {
    NSDictionary *barStyle = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:barStyle forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:barStyle forState:UIControlStateHighlighted];
    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];

    // TabBar
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];

    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)injection {
#if DEBUG
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
#endif
}

@end
