//
//  UIButton+Util.m
//  Ninesecretary
//
//  Created by JG on 2017/12/26.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "UIButton+Util.h"
#import <objc/runtime.h>

static const void *actionKey = &actionKey;

@interface UIButton ()
@property (nonatomic, copy) void (^action)(UIButton *sender);
@end

@implementation UIButton (Util)

- (void)setAction:(void (^)(UIButton *))action {
    objc_setAssociatedObject(self, actionKey, action, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIButton *))action {
    return objc_getAssociatedObject(self, actionKey);
}

- (void)addAction:(void (^)(UIButton *))action {
    self.action = action;
    [self addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickTo:(UIButton *)sender {
    if (self.action != nil) {
        self.action(sender);
    }
}

@end
