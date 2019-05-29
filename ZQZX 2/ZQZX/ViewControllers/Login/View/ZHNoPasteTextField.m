//
//  ZHNoPasteTextField.m
//  Ninesecretary
//
//  Created by chenglian on 2017/10/16.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "ZHNoPasteTextField.h"

@implementation ZHNoPasteTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    [UIMenuController sharedMenuController].menuVisible = NO;
    if (action == @selector(copy:)) {
        return NO;
    } else if (action == @selector(selectAll:)) {
        return NO;
    }
    return NO;
}

@end
