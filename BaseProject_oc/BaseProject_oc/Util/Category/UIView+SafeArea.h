//
//  UIView+SafeArea.h
//  BaseProject_oc
//
//  Created by liuliu on 2021/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SafeArea)

@property(nonatomic, strong, readonly) MASViewAttribute *md_top;
@property(nonatomic, strong, readonly) MASViewAttribute *md_bottom;
@property(nonatomic, strong, readonly) MASViewAttribute *md_left;
@property(nonatomic, strong, readonly) MASViewAttribute *md_right;

@end

NS_ASSUME_NONNULL_END
