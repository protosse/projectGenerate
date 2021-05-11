//
//  UIView+SafeArea.m
//  BaseProject_oc
//
//  Created by liuliu on 2021/4/25.
//

#import "UIView+SafeArea.h"
#import <Masonry/Masonry.h>

@implementation UIView (SafeArea)

-(MASViewAttribute *)md_top {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideTop;
    } else {
        return self.mas_top;
    }
}

-(MASViewAttribute *)md_bottom {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideBottom;
    } else {
        return self.mas_bottom;
    }
}

-(MASViewAttribute *)md_left {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideLeft;
    } else {
        return self.mas_left;
    }
}

-(MASViewAttribute *)md_right {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideRight;
    } else {
        return self.mas_right;
    }
}

@end
