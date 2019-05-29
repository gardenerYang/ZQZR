//
//  SuccessViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/11.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
typedef NS_ENUM(NSUInteger, SuccessType) {
    SuccessTypeDefault,
    SuccessTypeBtn,
};
NS_ASSUME_NONNULL_BEGIN

@interface SuccessViewController : ZHViewController
/**
 主标题
 */
@property (nonatomic, strong) NSString   *titleLbText;
/**
 副标题文本
 */
@property (nonatomic, strong) NSString   *srcLbText;
/**
 修改图片
 */
@property (nonatomic, strong) NSString   *imgName;
/**
 修改按钮标题
 */
@property (nonatomic, strong) NSString   *btnTitle;
/**
 修改按钮颜色
 */
@property (nonatomic, strong) UIColor   *btnBgColor;


- (void)showInVC:(ZHViewController *)vc;
- (void)showInVC:(ZHViewController *)vc type:(SuccessType )type;
- (void)dismiss;
@property (nonatomic, copy) void (^tapBtnblock)(void);
@property (nonatomic, copy) void (^Otherblock)(void);//几秒后自动跳转操作

@end

NS_ASSUME_NONNULL_END
