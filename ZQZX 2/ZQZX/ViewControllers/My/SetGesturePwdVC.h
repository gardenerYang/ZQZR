//
//  SetGesturePwdVC.h
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
typedef NS_ENUM(NSInteger, GestureViewType) {
    
    EditGesturePwdType = 1,
    
    ResetGesturePwdType = 2,
    
    ValidateGesturePwdType = 3,
    
    DeleteGesturePwdType = 4,
    
    NoneType = 5,
    
};

NS_ASSUME_NONNULL_BEGIN

@interface SetGesturePwdVC : ZHViewController
@property (nonatomic , assign) GestureViewType gestureType;

@end

NS_ASSUME_NONNULL_END
