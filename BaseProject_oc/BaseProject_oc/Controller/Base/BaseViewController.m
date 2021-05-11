//
//  BaseViewController.m
//  ShanjianUser
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    _isFirstIn = YES;
    _isAddBackButtonWhenNotFirst = YES;
    @weakify(self)
    [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(self)
        [self bindModel];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self hideNaviActionWhenWillAppear:animated];
}

-(void)hideNaviActionWhenWillAppear:(BOOL)animated {
    if(self.navigationController){
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    if(_isAddBackButtonWhenNotFirst && self.navigationController.viewControllers.count > 1){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setImage:R.image.iconBack forState:UIControlStateNormal];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.frame = CGRectMake(0, 0, 30, 18);
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return self.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)bindModel {
    [[self.errors takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSError *error) {
        [NSObject showHudTipStr:error.localizedDescription];
    }];
}

- (void)setIsStatusBarHidden:(BOOL)isStatusBarHidden {
    _isStatusBarHidden = isStatusBarHidden;
    [UIView animateWithDuration:0.5 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (RACSubject *)errors {
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark loading view

- (void)showLoadingView {
    [self hideLoadingView];
    _loadingView = [[DRLoadingView alloc] init];
    _loadingView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_loadingView];
    @weakify(self)
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
}

- (void)hideLoadingView {
    if (_loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = nil;
    }
}

@end
