//
//  RemindListSelectView.h
//  ZQZX
//
//  Created by yangshuai on 2019/4/19.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RemindListSelectView : UIView
- (void)remindUnfold;
- (void)remindrecover;
- (instancetype)initWithFrame:(CGRect)frame withOption:(NSInteger)option;
@property (nonatomic,assign) BOOL isUnfold;//是否展开状态
@property (nonatomic,assign) BOOL isInvest;//是否续投 默认yes
@property (nonatomic,strong) void (^ selectOption) (NSInteger option);
@property (nonatomic,strong) UIButton * topBtn;
@property (nonatomic,strong) UIButton * bottomBtn;

@end

NS_ASSUME_NONNULL_END
