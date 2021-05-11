//
//  DRLoadingView.m
//  loop
//
//  Created by doom on 16/7/7.
//  Copyright © 2016年 DOOM. All rights reserved.
//

#import "DRLoadingView.h"

@interface DRLoadingView ()

@property(nonatomic, copy) void (^failure)(void);
@property(nonatomic, strong) UILabel *whatTheLabel;
@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation DRLoadingView

+ (NSArray *)whatTheString {
    static NSArray *_whatTheString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _whatTheString = @[@"Justice has come",
                @"For those extra long days",
                @"Long may the sun shine",
                @"I smell magic in the air",
                @"In Nordrassil's name"];
    });
    return _whatTheString;
}

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        [self addSubview:_indicatorView];
        @weakify(self)
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-32);
        }];
        _whatTheLabel = [UILabel new];
        _whatTheLabel.textAlignment = NSTextAlignmentCenter;
        _whatTheLabel.numberOfLines = 0;

        _whatTheLabel.text = @"正在加载...";
        _whatTheLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_whatTheLabel];
        [_whatTheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerX.equalTo(self);
            make.top.equalTo(self.indicatorView.mas_bottom).offset(6);
            make.left.mas_equalTo(100);
        }];
    }
    return self;
}

- (void)performFailure:(void (^)(void))failure {
    [_indicatorView stopAnimating];
    _whatTheLabel.text = @"请求错误，点击重试";
    self.failure = failure;
}

- (void)performInfo:(NSString *)text failure:(void (^)(void))failure {
    [_indicatorView stopAnimating];
    _whatTheLabel.text = text;
    self.failure = failure;
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [_indicatorView startAnimating];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [_indicatorView stopAnimating];
}

#pragma mark gesture getter

- (void)setFailure:(void (^)(void))failure {
    if (!_failure) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    _failure = failure;
}

- (void)tapAction {
    BLOCK_EXEC(_failure);
}

@end
