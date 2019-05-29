//
//  UIButton+Util.h
//  Ninesecretary
//
//  Created by JG on 2017/12/26.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Util)
- (void)addAction:(void (^)(UIButton * _Nonnull sender))action;
@end
