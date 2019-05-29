//
//  Header.h
//  AliPayDemo
//
//  Created by pg on 15/7/10.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#ifndef AliPayDemo_Header_h
#define AliPayDemo_Header_h


#endif


/******************* ITEM *********************/

#define ITEMRADIUS_OUTTER     ([UIScreen mainScreen].bounds.size.height>482?([UIScreen mainScreen].bounds.size.height>600?70:60):60)  //item的外圆直径
#define ITEMRADIUS_INNER      ([UIScreen mainScreen].bounds.size.height>482?20:20)  //item的内圆直径
#define ITEMRADIUS_LINEWIDTH 1   //item的线宽
#define ITEMWH               ([UIScreen mainScreen].bounds.size.height>482?([UIScreen mainScreen].bounds.size.height>600?60:50):50)  //item的宽高
#define ITEM_TOTAL_POSITION  ([UIScreen mainScreen].bounds.size.height>482?([UIScreen mainScreen].bounds.size.height>600?250:200):150)  // 整个item的顶点位置
//[UIScreen mainScreen].bounds.size.width>320?250:150



//选中是否用图片
#define ITEMRADIUS_IMG     NO  //item的内圆直径

//选择的图片的名称
#define ITEMRADIUS_IMG_NAME     @""



/*********************** subItem *************************/

#define SUBITEMTOTALWH 50 // 整个subitem的大小
#define SUBITEMWH      12  //单个subitem的大小
#define SUBITEM_TOP    ([UIScreen mainScreen].bounds.size.height>482?([UIScreen mainScreen].bounds.size.height>600?80:50):50) //整个的subitem的顶点位置(y点)

/*********************** 颜色 *************************/

/**
 *  背景色   深蓝色
 */
#define BACKGROUNDCOLOR [UIColor colorWithRed:0.05 green:0.2 blue:0.35 alpha:1]

/**
 *  选中颜色  浅蓝色
 */
//#define SELECTCOLOR [UIColor colorWithRed:0.13 green:0.7 blue:0.96 alpha:1]
#define SELECTCOLOR [UIColor whiteColor]

/**
 *  选错的颜色  红色
 */
#define WRONGCOLOR [UIColor colorWithRed:1 green:0 blue:0 alpha:1]


/**
 *  文字错误提示颜色   浅红色
 */
#define LABELWRONGCOLOR [UIColor colorWithRed:0.94 green:0.31 blue:0.36 alpha:1]

/*********************** 文字提示语 *************************/
#define SETPSWSTRING                  @"请滑动设置密码"
#define RESETPSWSTRING                @"请再次滑动确认密码"
#define PSWSUCCESSSTRING              @"设置密码成功"
#define PSWFAILTSTRING                @"与上次绘制不一致,请重新绘制"
#define PSW_WRONG_NUMSTRING           @"请至少设置4个点"
#define INPUT_OLD_PSWSTRING           @"请输入原始密码"
#define INPUT_NEW_PSWSTRING           @"请输入新密码"
#define VALIDATE_PSWSTRING            @"验证密码"
#define VALIDATE_PSWSTRING_SUCCESS    @"登录成功"

#define ERROR_COUNT                   @"5"




