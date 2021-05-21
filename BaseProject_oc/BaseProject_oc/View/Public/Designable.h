//
//  Designable.h
//  BaseProject_oc
//
//  Created by doom on 2018/7/9.
//  Copyright © 2018年 doom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View : UIView

@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic, assign) IBInspectable CGFloat bwidth;
@property(nonatomic, assign) IBInspectable UIColor *bcolor;

@end

@interface ImageView : UIImageView

@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic, assign) IBInspectable CGFloat bwidth;
@property(nonatomic, assign) IBInspectable UIColor *bcolor;

@end

@interface Button : UIButton

@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic, assign) IBInspectable CGFloat bwidth;
@property(nonatomic, assign) IBInspectable UIColor *bcolor;

@end

@interface Label : UILabel

@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic, assign) IBInspectable CGFloat bwidth;
@property(nonatomic, assign) IBInspectable UIColor *bcolor;

@end
