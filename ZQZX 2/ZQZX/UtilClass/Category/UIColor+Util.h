//
//  UIColor+Util.h
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Util)
+ (UIColor *_Nonnull)withHexStr:(NSString *_Nonnull)hexStr;

/**
 红色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_red;
/**
 浅红
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_Lightred;
/**
 背景灰色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_gray;

/**
 灰色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_textGrayColor;
/**
 浅灰色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_textLighGrayColor;
/**
 深灰色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_textDeepGrayColor;

/**
 分割线颜色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_lineColor;
/**
 协议蓝色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_blue;

/**
 背景颜色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_bgColor;

/**
 辅助绿色
 */
@property (class, nonatomic, strong, readonly, nonnull) UIColor *m_greenColor;

@end

NS_ASSUME_NONNULL_END
