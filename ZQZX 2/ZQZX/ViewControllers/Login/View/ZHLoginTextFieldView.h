//
//  ZHLoginTextFieldView.h
//  Ninesecretary
//
//  Created by chenglian on 2017/8/2.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHNoPasteTextField.h"
@interface ZHLoginTextFieldView : UIView <UITextFieldDelegate>
@property (strong, nonatomic) UIView *tFView;
@property (strong, nonatomic) ZHNoPasteTextField *TextField;
@property (strong, nonatomic) UIImageView *TextFieldImageView;
@property (strong, nonatomic) NSString *imageName;//左边图片名字
@property (strong, nonatomic) UIImageView *stateImg;
@property (strong, nonatomic) UIButton *isHiddenBtn;

/**
 kvo修改清除图标颜色
 */
-(void)isModifyFieldClearBtn;
/**
 添加正确的图片
 */
-(void)addCorrectImg;
/**
 是否显示密码
 */
-(void)isHiddenPwd;

/**
 添加图片

 @param imgName 图片名字
 */
-(void)addCorrectImg:(NSString*)imgName;
/**
 添加隐藏m显示密码按钮
 */
-(void)addisHiddenBtn;
@end
