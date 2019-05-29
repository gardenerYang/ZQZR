//
//  AliPayViews.h
//  AliPayDemo
//
//  Created by pg on 15/7/9.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AlertPwdModel,    //修改密码 (需要先输入老密码)
    SetPwdModel,      //重置密码（无论存不存老密码都一并删除，在重新设置密码）
    ValidatePwdModel, //验证密码 (输入一遍，进行验证)
    DeletePwdModel,   //删除密码
    NoneModel
}GestureModel;


typedef enum {
    success = 0,    // 成功的回调
    failed  =1,      //失败的回调
    failedcount =2,  //失败超过5次的回调
    forgetPwd = 3,   //忘记手势密码
    changeAccount = 4, //切换用户
   
}Blocktype;

typedef void (^PasswordBlock) (NSString *pswString);


typedef void (^TypeBlock) (Blocktype type);
@interface AliPayViews : UIView
/**
 *  设置getsturemodel的类型
 */
@property(nonatomic , assign)GestureModel gestureModel;
/**
 *  手势密码的回调  类型 
     success = 0,    // 成功的回调
    failed  =1,      //失败的回调
    failedcount =2,  //失败超过5次的回调
 */
@property(nonatomic , strong)TypeBlock AliPayViewsBlcok;
-(void)cleartap;
@end
