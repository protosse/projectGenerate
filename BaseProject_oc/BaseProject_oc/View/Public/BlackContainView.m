//
//  BlackContainView.m
//  BaseProject_oc
//
//  Created by doom on 2018/7/10.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "BlackContainView.h"

@interface BlackContainView () <UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIView *containView;

@end

@implementation BlackContainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _containView = [UIView new];
        _containView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
        [self addSubview:_containView];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _containView.frame = CGRectMake(0, _containTop, kScreenWidth, kScreenHeight - _containTop);
}

@end
