//
//  NSObject+Common.m
//  BaseProject_oc
//
//  Created by doom on 2018/7/23.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <JDStatusBarNotification/JDStatusBarNotification.h>
#import <MBProgressHUD/MBProgressHUD.h>

@implementation NSObject (Common)

+ (NSString *)copyHistory:(NSString *)name {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [NSString stringWithFormat:@"%@/%@.plist", documentPath, name];
    return path;
}

+ (NSArray *)allHistory:(NSString *)name {
    NSString *filePath = [self copyHistory:name];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    return array;
}

+ (void)clearHistory:(NSString *)name {
    NSString *filePath = [self copyHistory:name];
    [@[] writeToFile:filePath atomically:YES];
}

+ (void)writeHistory:(NSString *)histroy name:(NSString *)name {
    if (histroy.length == 0) {
        return;
    }
    NSString *filePath = [self copyHistory:name];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    BOOL is_contain = NO;
    NSMutableArray *historyArray = [NSMutableArray new];
    for (NSString *str in array) {
        [historyArray addObject:str];
    }

    for (NSString *str in array) {
        if ([str isEqualToString:histroy]) {
            is_contain = YES;
            break;
        }
    }

    if (!is_contain) {
        [historyArray addObject:histroy];
        if (historyArray.count > 10) {
            [historyArray removeObjectAtIndex:0];
        }
        [historyArray writeToFile:filePath atomically:YES];
    }
}

+ (void)showHudTipStr:(NSString *)tipStr {
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.detailsLabel.text = tipStr;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:2.0];
    }
}

+ (MBProgressHUD *)showHUDQueryStr:(NSString *)titleStr {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.label.text = titleStr;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.font = [UIFont boldSystemFontOfSize:15.0];
    return hud;
}

+ (void)hideHUDQuery {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:kKeyWindow];
    [hud removeFromSuperview];
}

+ (void)showStatusBarQueryStr:(NSString *)tipStr {
    [JDStatusBarNotification showWithStatus:tipStr styleName:JDStatusBarStyleSuccess];
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
}

+ (void)showStatusBarSuccessStr:(NSString *)tipStr {
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:tipStr dismissAfter:2.5 styleName:JDStatusBarStyleSuccess];
        });
    } else {
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:tipStr dismissAfter:2.0 styleName:JDStatusBarStyleSuccess];
    }
}

+ (void)showStatusBarErrorStr:(NSString *)errorStr {
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:errorStr dismissAfter:2.5 styleName:JDStatusBarStyleError];
        });
    } else {
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:errorStr dismissAfter:2.5 styleName:JDStatusBarStyleError];
    }
}

- (void)changeToLogin {
//    UIView *snapShot = [kKeyWindow snapshotViewAfterScreenUpdates:YES];
//    [[NH_ChatHelper shareChatHelper] logoutUser:^(BOOL result) {
//        [UserModel doLogout];
//    }];
//    UINavigationController *nav = R.storyboard.main.loginNavigationController;
//    [nav.view addSubview:snapShot];
//
//    kKeyWindow.rootViewController = nav;
//
//    [UIView animateWithDuration:0.3 animations:^{
//        snapShot.layer.opacity = 0;
//        snapShot.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
//    } completion:^(BOOL finished) {
//        [snapShot removeFromSuperview];
//    }];
}

- (void)changeToRootTab {
//    UIView *snapShot = [kKeyWindow snapshotViewAfterScreenUpdates:YES];
//    UITabBarController *tab = R.storyboard.main.rootTabBarController;
//    [tab.view addSubview:snapShot];
//
//    kKeyWindow.rootViewController = tab;
//
//    [UIView animateWithDuration:0.3 animations:^{
//        snapShot.layer.opacity = 0;
//        snapShot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
//    } completion:^(BOOL finished) {
//        [snapShot removeFromSuperview];
//    }];
}

@end
