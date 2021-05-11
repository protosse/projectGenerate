//
//  NSString+Valid.m
//  ShanjianUser
//
//  Created by doom on 2018/7/10.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "NSString+Valid.h"
#import "RegExCategories.h"

@implementation NSString (Valid)

- (BOOL)isNumber {
    return [RX(@"^\\d+$") isMatch:self];
}

- (BOOL)isPhone {
    return [RX(@"^1\\d{10}$") isMatch:self];
}

- (BOOL)isEmail {
    return [RX(@"^[A-Za-z0-9\\u4e00-\\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$") isMatch:self];
}

- (BOOL)isMoney {
    return [RX(@"^\\d+$|^\\d+\\.\\d{1,2}$") isMatch:self];
}

-(BOOL)isPwd {
    return [RX(@"^[a-zA-Z0-9]{6,10}$") isMatch:self];
}

@end
