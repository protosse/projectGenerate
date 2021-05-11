//
//  UIImageView+Common.m
//  ShanjianUser
//
//  Created by doom on 2018/7/10.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "UIImageView+Common.h"

@implementation UIImageView (Common)

-(void)setImageWithUrl:(NSString *)url {
    [self setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageWithColor:UIColorHex(f5f5f5)]];
}

@end
