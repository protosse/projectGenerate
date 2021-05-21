//
//  NSString+Valid.h
//  BaseProject_oc
//
//  Created by doom on 2018/7/10.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Valid)

- (BOOL)isNumber;

- (BOOL)isPhone;

- (BOOL)isEmail;

- (BOOL)isMoney;

- (BOOL)isPwd;

@end
