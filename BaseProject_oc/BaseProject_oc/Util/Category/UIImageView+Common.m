//
//  UIImageView+Common.m
//  BaseProject_oc
//
//  Created by doom on 2018/7/10.
//  Copyright © 2018年 doom. All rights reserved.
//

@implementation UIImageView (Common)

- (void)setImageWithUrl:(NSString *)url {
    [self setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageWithColor:UIColorHex(f5f5f5)]];
}

@end
