//
//  UIViewController+Util.h
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMHUDView.h"
#import "NoDataView.h"
#import "WebviewViewController.h"
#import "InvestmentdetailsVC.h"
#import "SetGesturePwdVC.h"
/**
 * 时间戳类型
 */
typedef enum _TimeStampType {
    
    kTimeStampWithSecond = 0,
    kTimeStampDateOnlyHorizonLine ,
    kTimeStampDateOnlySlashLine,
    kTimeStampDateOnlyTextLine

    
}TimeStampType;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Util)
@property (nonatomic, strong) JMHUDView  *jmHud;

/**
 弹出登陆
 */
-(void)toLoginVC;
-(void)toLoginVCcompletion:(void (^)(void))completion;
/**
 添加地步暗影图片
 */
-(void)addBottomIMG;

/////////
/**
 获取当前显示页面的控制器
 
 @return 当前显示页面的控制器
 */
+ (UIViewController *)currentViewController;
//MARK: - 活动指示器
/**
 显示带文字的活动指示器
 */
- (void)showHubWithMsg:(NSString *)msg;
/**
 隐藏活动指示器
 */
- (void)hide;
/**
 隐藏活动指示器，并显示在指定时间内消失的提示性文字
 */
- (void)hideWithMsg:(NSString *)msg;
/**
 * 获取格式化时间字符串
 *
 * @param timeStamp 长整型时间戳
 * @param type      格式化字符串类型
 * @return 格式化好的时间字符串
 */
-(NSString*)parseTimeStamp:(NSString*)timeStamp withType:(TimeStampType)type;

///////////////////////////////////////无数据界面展示////////////////
//MARK: - 无数据提示页面
/**
 有按钮无数据
 
 @param ImageName ImageName description
 @param Title 标题
 @param BtnTitle BtnTitle description
 @param toEnter 点击按钮相应事件
 */
-(void)AddNodataView:(NSString*)ImageName :(NSString*)Title :(NSString*)BtnTitle selector:(void (^)(void))toEnter reload:(void (^)(void))reload;
/**
 无按钮无数据
 
 @param ImageName ImageName description
 @param Title 标题
 */
-(void)addNodataView:(NSString*)ImageName :(NSString*)Title reload:(void (^)(void))reload;

/**
 隐藏无数据提示
 */
- (void)hideNoDataView;

/**
 消息界面无数据时调用
 */
- (void)addNoDataView:(NoDataDetailType)type reload:(void (^)(void))reload;
- (void)addNoDataView:(NoDataDetailType)type selector:(void (^)(void))toEnter reload:(void (^)(void))reload;
/////////////////////////////////////
/**
 打电话

 @param telNum 所拨打的电话
 */
- (void)tel:(NSString *)telNum;

////////////跳转网页
/**
 网页加载代码片段

 @param htmlText 代码片段
 */
-(void)gotoWebHtml:(NSString *)htmlText title:(NSString *)titleStr ;

/**
 网页跳转URL

 @param url URL
 */
-(void)gotoWebURL:(NSString *)url title:(NSString *)titleStr;

/**
 跳转网页

 @param url URL
 @param htmlText 代码片段
 */
-(void)gotoWebURL:(NSString *)url htmlText:(NSString *)htmlText title:(NSString *)titleStr;

/**
 跳转票据详情

 @param productID 产品ID
 */
-(void)gotoInvestmentdetailsVC:(NSString *)productID title:(NSString *)title status:(NSInteger )status;

/**
 *  设置手势密码
 *
 *  @param controler 起跳VC
 */
-(void)jumpToSetGesturePwdFromVC:(UIViewController *)controler withGestureType:(GestureViewType)type :(void(^) ())resultCallBack;
/**
 金钱判断

 @param money 金额
 @return return value description
 */
-(NSString *)moneyStr:(NSInteger )money;

/**
 手机号中间四位显示****

 @param phoneStr 手机号
 @return return value description
 */
-(NSString *)phone:(NSString *)phoneStr;
/**
 姓名加*

 @param nameStr 姓名
 @return return value description
 */
-(NSString *)name:(NSString *)nameStr;


/**
 年化率百分比

 @param annualRateStr annualRateStr description
 @return return value description
 */
-(NSString *)annualRate:(NSString *)annualRateStr;


/**
 预约金额

 @param money money description
 @return return value description
 */
-(NSString *)appointmentMoneyStr:(NSString *)moneyStr;

@end


NS_ASSUME_NONNULL_END
