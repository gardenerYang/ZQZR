//
//  TipsViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TipsViewController : ZHViewController
/**
 主标题
 */
@property (nonatomic, strong) NSString   *titleLbText;
/**
 副标题文本
 */
@property (nonatomic, strong) NSString   *srcLbText;
- (void)showInVC:(ZHViewController *)vc;
- (void)dismiss;
/**
 取消
 */
@property (nonatomic, copy) void (^tapCancelBtnblock)(void);
/**
 确定
 */
@property (nonatomic, copy) void (^tapConfirmBtnblock)(void);

@end

NS_ASSUME_NONNULL_END
