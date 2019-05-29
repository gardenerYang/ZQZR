//
//  ZHSwitch.h
//  Ninesecretary
//
//  Created by chenglian on 16/5/30.
//  Copyright © 2016年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZHSwitchStyle) {
    ZHSwitchStyleNoBorder,
    ZHSwitchStyleBorder
};
@interface ZHSwitch : UIControl
@property (nonatomic, assign, getter = isOn) BOOL on;

@property (nonatomic, assign) ZHSwitchStyle style;

@property (nonatomic, strong) UIColor *onTintColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *thumbTintColor;

@property (nonatomic, strong) UIColor *onTextColor;
@property (nonatomic, strong) UIColor *offTextColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) NSString *onText;
@property (nonatomic, strong) NSString *offText;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
@end
