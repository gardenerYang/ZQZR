//
//  HomeNotificationView.m
//  ZQZX
//
//  Created by yangshuai on 2019/4/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "HomeNotificationView.h"

@implementation HomeNotificationView

- (void)drawRect:(CGRect)rect {
    [self.cancelBtn addTapGestureBlock:^(UIView *view) {
        [self hide];
    }];
}
- (void)show{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 1;
    }];
}
- (void)hide{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
