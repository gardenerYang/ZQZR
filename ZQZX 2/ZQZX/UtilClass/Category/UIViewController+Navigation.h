//
//  UIViewController+Navigation.h
//  Ninesecretary
//
//  Created by 少爷 on 2017/6/13.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Navigation)

- (void)setCustomerTitle:(NSString *)title;
- (void)setCustomerTitle:(NSString *)title color:(UIColor *)color;

- (UIBarButtonItem *)setLeftBarButtonItemWithImg:(NSString *)img selector:(void (^)(id))selector;
- (UIBarButtonItem *)setRightBarButtonItem:(NSString *)title selector:(void (^)(id sender))selector;
- (UIBarButtonItem *)setRightBarButtonItemWithImg:(NSString *)img selector:(void (^)(id sender))selector;


@end
