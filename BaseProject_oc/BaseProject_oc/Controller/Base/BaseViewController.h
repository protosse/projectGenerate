//
//  BaseViewController.h
//  BaseProject_oc
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRLoadingView.h"

@interface BaseViewController : UIViewController

@property(nonatomic, assign) BOOL isFirstIn; //default is YES
@property(nonatomic, assign) BOOL isAddBackButtonWhenNotFirst; //default is YES
@property(nonatomic, strong) RACSubject *errors;

@property(nonatomic, strong) DRLoadingView *loadingView;

@property(nonatomic, assign) BOOL isStatusBarHidden;

/// after init call
- (void)customInit;

/// call after viewDidLayoutSubviews
- (void)layoutUI;

/// call after viewDidLoad
- (void)bindModel;

/// default is NO
- (void)hideNaviActionWhenWillAppear:(BOOL)animated;

- (void)showLoadingView;

- (void)hideLoadingView;

@end
