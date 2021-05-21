//
//  ViewController.m
//  BaseProject_oc
//
//  Created by liuliu on 2021/4/25.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIButton *pushButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _pushButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"Push" forState:UIControlStateNormal];
        button;
    });

    [self.view addSubview:_pushButton];
    @weakify(self)
    [self.pushButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id _Nonnull sender) {
        @strongify(self)
        [self.navigationController pushViewController:[ViewController new] animated:YES];
    }];
}

- (void)layoutUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.pushButton.pinObjc.leftValue(100).topValue(50).sizeToFit().layout();
}

@end
