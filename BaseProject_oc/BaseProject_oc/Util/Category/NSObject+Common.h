//
//  NSObject+Common.h
//  BaseProject_oc
//
//  Created by doom on 2018/7/23.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface NSObject (Common)

/// search key
+ (NSArray *)allHistory:(NSString *)name;

+ (void)clearHistory:(NSString *)name;

+ (void)writeHistory:(NSString *)history name:(NSString *)name;

/// hud
+ (void)showHudTipStr:(NSString *)tipStr;

+ (MBProgressHUD *)showHUDQueryStr:(NSString *)titleStr;

+ (void)hideHUDQuery;

+ (void)showStatusBarQueryStr:(NSString *)tipStr;

+ (void)showStatusBarSuccessStr:(NSString *)tipStr;

+ (void)showStatusBarErrorStr:(NSString *)errorStr;

- (void)changeToLogin;

- (void)changeToRootTab;

@end
