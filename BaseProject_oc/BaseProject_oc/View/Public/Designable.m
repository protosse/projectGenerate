//
//  Designable.m
//  BaseProject_oc
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import "Designable.h"

IB_DESIGNABLE
@implementation View

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor {
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}

@end

IB_DESIGNABLE
@implementation ImageView

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor {
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}

@end

IB_DESIGNABLE
@implementation Button

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor {
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}

@end

IB_DESIGNABLE
@implementation Label

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor {
    _bcolor = bcolor;
    self.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    self.layer.borderWidth = _bwidth;
}

@end
