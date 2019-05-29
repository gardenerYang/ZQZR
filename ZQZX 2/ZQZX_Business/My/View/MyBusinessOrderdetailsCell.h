//
//  MyBusinessOrderdetailsCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/24.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBusinessOrderdetailsCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, strong) UILabel       *titleLb;
@property (nonatomic, strong) UITextField       *textField;
@property (nonatomic, strong) UIImageView       *jianImg;
@property (nonatomic, strong) UIView       *lineView;

@end

NS_ASSUME_NONNULL_END
