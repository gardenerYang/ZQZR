//
//  BaseTableViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
#import "NSNotificationCenter+Util.h"
#import "UITableView+Register.h"
//#import "UITableView+Animation.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : ZHViewController
- (instancetype)initWithTableStyle:(UITableViewStyle)style;

@property (nonatomic, strong) UITableView *tableView;

- (void)setTableViewEdges:(UIEdgeInsets)edges;
- (Class)tableViewClass;
- (UIView *)findFirstResponderBeneathView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
