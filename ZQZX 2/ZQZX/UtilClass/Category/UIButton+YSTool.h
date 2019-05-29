//
//  UIButton+YSTool.h
//  YSClient
//
//  Created by yangshuai on 2018/7/2.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, YSButtonEdgeInsetsStyle) {
    YSButtonEdgeInsetsStyleTop, // image在上，label在下
    YSButtonEdgeInsetsStyleLeft, // image在左，label在右
    YSButtonEdgeInsetsStyleBottom, // image在下，label在上
    YSButtonEdgeInsetsStyleRight // image在右，label在左
};
@interface UIButton (YSTool)
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
- (void)preventRepeatClick;
/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(YSButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
