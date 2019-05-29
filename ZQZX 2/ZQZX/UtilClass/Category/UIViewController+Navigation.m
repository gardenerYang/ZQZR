//
//  UIViewController+Navigation.m
//  Ninesecretary
//
//  Created by 少爷 on 2017/6/13.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import <objc/runtime.h>
#import "UIButton+SSEdgeInsets.h"
const void *key = "Selector";
const void *leftKey = "leftSelector";

@interface UIViewController ()
@property (nonatomic, copy) void (^selector) (id sender);
@property (nonatomic, copy) void (^leftSelector) (id sender);
@end

@implementation UIViewController (Navigation)

- (void)setSelector:(void(^)(id))selector {
    objc_setAssociatedObject(self, key, [selector copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(id))selector {
    return objc_getAssociatedObject(self, key);
}

- (void)setLeftSelector:(void (^)(id))leftSelector {
    objc_setAssociatedObject(self, leftKey, [leftSelector copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(id))leftSelector {
    return objc_getAssociatedObject(self, leftKey);
}

-(void)setCustomerTitle:(NSString *)title{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
}
- (void)setCustomerTitle:(NSString *)title color:(UIColor *)color
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = title;
    titleLabel.textColor = color;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
}

- (UIBarButtonItem *)setLeftBarButtonItemWithImg:(NSString *)img selector:(void (^)(id))selector {
    self.leftSelector = selector;
    
    UIButton *barBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [barBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [barBtn addTarget:self action:@selector(selectLeftBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    [barBtn setEdgeInsetsWithType:SSEdgeInsetsTypeImage marginType:SSMarginTypeLeft margin:0];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barBtn];
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)setRightBarButtonItem:(NSString *)title selector:(void (^)(id))selector {
    self.selector = selector;
    
    UIButton *barBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    [barBtn addTarget:self action:@selector(selectBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    [barBtn setTitle:title forState:UIControlStateNormal];
    [barBtn setTitleColor:[UIColor m_textGrayColor] forState:UIControlStateNormal];
    barBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [barBtn setEdgeInsetsWithType:SSEdgeInsetsTypeImage marginType:SSMarginTypeRight margin:10];
    barBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barBtn];
    self.navigationItem.rightBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)setRightBarButtonItemWithImg:(NSString *)img selector:(void (^)(id))selector {
    self.selector = selector;

    UIButton *barBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [barBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [barBtn addTarget:self action:@selector(selectBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    [barBtn setEdgeInsetsWithType:SSEdgeInsetsTypeImage marginType:SSMarginTypeRight margin:0];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barBtn];
    self.navigationItem.rightBarButtonItem = item;
    return item;
}

- (void)selectBarButtonItem:(id)sender {
    
    if (self.selector) {
        self.selector(sender);
    }
}

- (void)selectLeftBarButtonItem:(id)sender {
    
    if (self.leftSelector) {
        self.leftSelector(sender);
    }
}

@end
