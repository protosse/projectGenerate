//
//  DRLoadingView.h
//  loop
//
//  Created by doom on 16/7/7.
//  Copyright © 2016年 DOOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRLoadingView.h"

@interface DRLoadingView : UIView

- (void)performFailure:(void (^)(void))failure;

- (void)performInfo:(NSString *)text failure:(void (^)(void))failure;

@end
