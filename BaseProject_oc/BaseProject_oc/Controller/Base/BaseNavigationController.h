//
//  BaseNavigationController.h
//  BaseProject_oc
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

/// block after the navigation dismiss.
@property(nonatomic, copy) VoidBlock dismissBlock;

@end
