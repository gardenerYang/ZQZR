//
//  RequestedURL.h
//  ZQZX
//
//  Created by 中企 on 2018/10/17.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#ifndef RequestedURL_h
#define RequestedURL_h

#define AppKey @""//正式
#define AppSecret @""//新版本



/* 获取版本号*/
#define http_getVersion @"commonSetting/getVersion"//获取版本号
/* 获取七牛token*/
#define getQiniuToken @"getQiniuToken"





/*登录界面*/
#define login_doLogin @"user/doLogin"//登录
#define register_financialPlanner @"user/financialPlanner"//申请理财师

/*注册*/
#define register_sendCode @"user/sendCode"//用户注册验证码
#define nextStep @"user/nextStep"//用户注册下一步提交 ,找回密码-下一步,修改登录密码-下一步
#define register_register @"user/register"//用户注册提交
#define register_financialPlanner @"user/financialPlanner"//申请理财师

/*忘记密码//找回登录密码*/
#define pwd_forgetPassword @"user/forgetPassword"//找回密码-验证码
#define pwd_forgetPassword_forgetPwSub @"user/forgetPwSub"//忘记密码提交


/*首页*/
#define http_home_getSysScrollImages  @"home/getSysScrollImages"//首页活动轮播图
#define home_getTopOrSuggInvestions  @"home/getTopOrSuggInvestions"//首页其他数据
#define home_getHomeProductsByParam  @"home/getHomeProductsByParam"//首页-票据列表数据
#define home_investment_getInvestmentById  @"investment/getInvestmentById"//首页产品列表--详情
#define home_getProductDetail  @"home/getProductDetail"//首页产品详情
#define home_getProductLog  @"home/getProductLog"//首页产品详情 - 预约记录
#define home_makeReservation @"home/makeReservation"//产品详情 - 预约
#define home_getProductTicketsByPId @"home/getProductTicketsByPId"//票面信息
#define activity_intoActivity @"activity/intoActivity"//参加活动
#define home_remindUserOrFinancialPlanner @"home/remindUserOrFinancialPlanner"//续投提醒
#define my_insertInvestmentApplyFor @"my/insertInvestmentApplyFor"//提交续投
/*发现*/
#define find_getMomentByParam  @"moment/getMomentByParam"//发现

/*活动*/
#define activity_homePage  @"activity/homePage"//发现


/*我的*/
#define my_homePage  @"my/homePage"//我的首页

#define my_message  @"my/message"//我的信息
#define my_moneyRecord  @"my/moneyRecord"//资金记录
#define my_indent  @"my/indent"//我的订单
#define my_indentDetails  @"my/indentDetails"//我的订单 - 详情
#define my_cancelDetails  @"my/cancelDetails"//我的订单 - 详情-取消订单

#define my_returnMoneySchemes  @"my/returnMoneySchemes"//回款计划
#define my_schemesDetails  @"my/schemesDetails"//回款计划详情
#define my_insertApplyFor  @"my/insertApplyFor"//续投/赎回

#define my_authenticationUser  @"commonSetting/authenticationUser"//实名认证提交
#define my_bankCardList  @"my/bankCardList"//银行卡列表
#define my_bankCheck  @"commonSetting/bankCheck"//绑定银行卡
#define my_unbindBankCard  @"my/unbindBankCard"//解绑银行卡

//////////设置////////
#define my_setting_changePhone  @"setting/changePhone"//修改手机号发送验证码(旧手机,新手机)
#define my_setting_nextStep  @"setting/nextStep" //修改手机号下一步(旧手机,新手机)
#define my_setting_doLogout  @"setting/doLogout" //设置-退出登录
#define my_setting_opinion  @"setting/opinion" //设置-意见反馈

#define my_upload  @"my/upload" //更新头像
#define my_getQuestionList  @"q/getQuestionList" //获取问题
#define my_getInvestorQReslt  @"q/getInvestorQReslt" //获取测评结果
#define my_markingAnswe @"q/markingAnswer" //提交问题答案
#define my_investorConfirm @"my/investorConfirm" //合格投资者确认


#pragma mark 门店端接口

/*我的*/

#define my_Business_getFinancialPlannerInfo  @"user/getFinancialPlannerInfo" //获取用户信息
#define Business_getInvestmentByParam  @"investment/getInvestmentByParam" //获取订单
#define Business_getBillDetailById  @"investment/getBillDetailById" //获取订单详情
#define Business_saveInvestmentCertificate  @"investment/saveInvestmentCertificate" //上传打款凭证
#define Business_getBankNoByInvestmentId  @"investment/getBankNoByInvestmentId" //获取用户银行卡
#define Business_updateInvestmentById  @"investment/updateInvestmentById" //更新订单信息

#define Business_getUserInvestmentManager  @"user/getUserInvestmentManager" //用户投资管理
#define Business_getCustomers  @"user/getCustomers" //我的用户
#define Business_achievementCount  @"user/achievementCount" //用户统计
#define Business_achievementCountAll  @"user/achievementCountAll" //用户统计全部
#define Business_updateFinancialPlannerInfo  @"user/updateFinancialPlannerInfo" //按ID更新理财师信息
#define Business_getOldTextCode  @"setting/getOldTextCode" //获取旧手机短信验证码
#define Business_checkTextCode  @"setting/checkTextCode" //获取旧手机短信验证码下一步
#define Business_sendText  @"commonSetting/sendText" //获取新手机短信验证码
#define Business_updatePhone  @"setting/updatePhone" //提交
#define Business_updatePassword  @"setting/updatePassword" //更新密码


////////////////////////////网页跳转/////////////////////////////////
#define user_serviceAgreement  @"view/serviceAgreement"//用户注册查看协议接口
#define user_xqCompact  @"view/xqCompact"//用户注册查看协议接口


#endif /* RequestedURL_h */
