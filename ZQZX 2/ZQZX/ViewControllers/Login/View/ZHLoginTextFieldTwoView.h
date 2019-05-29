//
//  ZHLoginTextFieldTwoView.h
//  ZQZX
//
//  Created by 中企 on 2018/10/11.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHNoPasteTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHLoginTextFieldTwoView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIView *tFView;
@property (strong, nonatomic) ZHNoPasteTextField *TextField;
@property (strong, nonatomic) UILabel *nameLb;
/**
 kvo修改清除图标颜色
 */
-(void)isModifyFieldClearBtn;


@end

NS_ASSUME_NONNULL_END
