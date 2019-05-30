//
//  UIViewController+Util.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "UIViewController+Util.h"
#import "LoginViewController.h"
#import "ZHNavigationViewController.h"
#import <objc/runtime.h>
#import <MessageUI/MessageUI.h>

static UIWebView *callWebView;

@interface UIViewController () <MFMailComposeViewControllerDelegate>

@end
static const void *noViewKey = &noViewKey;

@implementation UIViewController (Util)

-(void)toLoginVC{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    ZHNavigationViewController *nav = [[ZHNavigationViewController alloc]initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
-(void)toLoginVCcompletion:(void (^)(void))completion{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    ZHNavigationViewController *nav = [[ZHNavigationViewController alloc]initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:^{
    }];
}
/**
 添加地步暗影图片
 */
-(void)addBottomIMG{
    UIImageView *bottomImg = [[UIImageView alloc]init];
    bottomImg.image = [UIImage imageNamed:@"loginBottom"];
    [self.view addSubview:bottomImg];
    [bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomImg.mas_width).multipliedBy(0.25);
    }];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)currentViewController
{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *subViews = window.subviews;
    if (subViews == nil || subViews.count == 0) {
        return window.rootViewController;
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = [UIViewController getViewController:nextResponder];
    } else {
        result = window.rootViewController;
    }
    
    return result;
}

+ (UIViewController *)getViewController:(id)sender {
    if ([sender isKindOfClass:[UINavigationController class]]) {
        sender = [(UINavigationController *)sender topViewController];
        return [UIViewController getViewController:sender];
    } else if ([sender isKindOfClass:[UITabBarController class]]) {
        sender = [(UITabBarController *)sender selectedViewController];
        return [UIViewController getViewController:sender];
    }
    return sender;
}

//- (void)setHud:(MBProgressHUD *)hud {
//    objc_setAssociatedObject(self, hudKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (MBProgressHUD *)hud {
//    return objc_getAssociatedObject(self, hudKey);;
//}

- (void)setJmHud:(JMHUDView *)jmHud {
    objc_setAssociatedObject(self, @selector(jmHud), jmHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JMHUDView *)jmHud {
    JMHUDView *hudView = objc_getAssociatedObject(self, _cmd);
    
    if (hudView == nil) {
        hudView = [[JMHUDView alloc] init];
        self.jmHud = hudView;
    }
    
    return hudView;
}

//- (MBProgressHUD *)getHud {
//    if (self.hud == nil) {
//        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        self.hud.removeFromSuperViewOnHide = NO;
//        self.hud.color = [UIColor colorWithWhite:1 alpha:0.5];
//        self.hud.labelColor = kTitleColor;
//        self.hud.opacity = 0.5f;
//    }
//
//    [self.view bringSubviewToFront:self.hud];
//
//    return self.hud;
//}

- (void)showHubWithMsg:(NSString *)msg {
    [self.jmHud setType:JMHUDTypeLoading message:msg];
    [self.jmHud showInView:[self finalView]];
}

- (void)hide {
    [self hideWithMsg:nil];
}

- (void)hideWithMsg:(NSString *)msg {
    __weak typeof(self) wf = self;
    [self.jmHud dismissWithComplete:^{
        if (msg != nil) {
            [wf.jmHud setType:JMHUDTypeMessage message:msg];
            UIView *final = [wf finalView];
            [wf.jmHud showInView:final];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wf.jmHud dismiss];
            });
        }
    }];
}
- (UIView *)finalView {
    UIView *superView;
    
    if (self.navigationController != nil) {
        superView = self.navigationController.topViewController.view;
    } else {
        NSArray<UIView *>*subViews = [UIApplication sharedApplication].keyWindow.subviews;
        
        for (UIView *view in subViews) {
            if (CGRectEqualToRect(view.frame, CGRectMake(0, 0, Iphonewidth, IphoneHight)) && self.navigationController) {
                superView = view;
                break;
            }
        }
    }
    return superView;
}
-(NSString*)parseTimeStamp:(NSString*)timeStamp withType:(TimeStampType)type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    
    switch (type) {
        case kTimeStampWithSecond:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case kTimeStampDateOnlyHorizonLine:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case kTimeStampDateOnlySlashLine:
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            break;
        case kTimeStampDateOnlyTextLine:
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
            break;
            
        default:
            return nil;
    }
    
    NSDate *theday = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]/1000.f];
    
    NSString *day = [dateFormatter stringFromDate:theday];
    
    return day;
}
////////////////////
//TODO: set
- (void)setNoView:(NoDataView *)noView {
    objc_setAssociatedObject(self, noViewKey, noView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NoDataView *)noView {
    return objc_getAssociatedObject(self, noViewKey);
}

-(void)addNodataView:(NSString*)ImageName :(NSString*)Title reload:(void (^)(void))reload {
    if (self.noView == nil) {
        self.noView = [[NoDataView alloc] initWithType:NoDataTypeDefault];
        self.noView.backgroundColor = [UIColor whiteColor];
    }
    self.noView.hidden = NO;
    [self.noView setReloadData:reload];
    
    [self.view addSubview:self.noView];
    
    if (ImageName.length>0) {
        self.noView.imgView.image=[UIImage imageNamed:ImageName];
    }
    
    if (Title.length>0) {
        self.noView.titleLb.text=Title;
    }
    [self.noView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.bottom.mas_equalTo(-80);
        make.left.right.mas_equalTo(0);

    }];
}

-(void)AddNodataView:(NSString*)ImageName
                    :(NSString*)Title
                    :(NSString*)BtnTitle
            selector:(void (^)(void))toEnter
              reload:(void (^)(void))reload
{
    if (self.noView == nil) {
        self.noView = [[NoDataView alloc] initWithType:NoDataTypeSelected];
    }
    self.noView.hidden = NO;
    [self.noView setReloadData:reload];
    
    [self.view addSubview:self.noView];
    
    if (ImageName.length>0) {
        self.noView.imgView.image=[UIImage imageNamed:ImageName];
    }
    
    if (Title.length>0) {
        self.noView.titleLb.text=Title;
    }
    
    if (BtnTitle.length>0) {
        [self.noView.detailBtn setTitle:[NSString stringWithFormat:@"%@ >",BtnTitle] forState:UIControlStateNormal];
        [self.noView setToEnter:toEnter];
    }
    
    [self.noView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)hideNoDataView {
    if (self.noView != nil) {
        self.noView.hidden = YES;
    }
}

- (void)addNoDataView:(NoDataDetailType)type selector:(void (^)(void))toEnter reload:(void (^)(void))reload {
    
    switch (type) {
        case NoDataDetailTypeNews:
            [self addNodataView:@"NomessageImage" :@"暂时还没有消息哦～" reload:reload];
            break;
        case NoDataDetailTypeDefault:
            [self addNodataView:@"NodataImage" :@"暂时还没有任何数据哦～" reload:reload];
            break;
        case NoDataDetailTypeShopping:
            [self AddNodataView:@"NogoodsImage" :@"您还没有买过任何东西哦～" :@"去商城逛逛 >" selector:toEnter reload:reload];
            break;
        default:
            break;
    }
}

- (void)addNoDataView:(NoDataDetailType)type reload:(void (^)(void))reload {
    [self addNoDataView:type selector:nil reload:reload];
}
/////////////////////////////////
- (void)tel:(NSString *)telNum {
    
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", telNum]];
    float version = round([UIDevice currentDevice].systemVersion.floatValue * 100);
    if (version < (10.3 * 100)) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            callWebView = [[UIWebView alloc] init];
            [self.view addSubview:callWebView];
        });
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    } else {
//        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:telURL options:@{} completionHandler:nil];
//        } else {
//            // Fallback on earlier versions
//        }
    }
}

////////////跳转网页
/**
 网页加载代码片段
 
 @param htmlText 代码片段
 */
-(void)gotoWebHtml:(NSString *)htmlText title:(NSString *)titleStr{
    WebviewViewController *web = [[WebviewViewController alloc]init];
    web.htmlText = htmlText;
    if (titleStr.length >0) {
        [web setCustomerTitle:titleStr];
    }
    [self.navigationController pushViewController:web animated:YES];
}

/**
 网页跳转URL
 
 @param url URL
 */
-(void)gotoWebURL:(NSString *)url title:(NSString *)titleStr{
    if (url.length == 0) {
        return;
    }
    WebviewViewController *web = [[WebviewViewController alloc]init];
    web.url = url;
    if (titleStr.length >0) {
        [web setCustomerTitle:titleStr];
    }
    [self.navigationController pushViewController:web animated:YES];
}
/**
 跳转网页
 
 @param url URL
 @param htmlText 代码片段
 */
-(void)gotoWebURL:(NSString *)url htmlText:(NSString *)htmlText title:(NSString *)titleStr{
    if (url.length > 0) {
        [self gotoWebURL:url title:titleStr];
    }
    else if(htmlText.length > 0) {
        [self gotoWebHtml:htmlText title:titleStr];
    }else{
        return;
    }
}
/**
 跳转票据详情
 
 @param productID 产品ID
 */
-(void)gotoInvestmentdetailsVC:(NSString *)productID title:(NSString *)title status:(NSInteger )status
{
    InvestmentdetailsVC *investmentdetailsVC = [[InvestmentdetailsVC alloc]init];
    investmentdetailsVC.productID = productID;
    investmentdetailsVC.status = status;
    [investmentdetailsVC setCustomerTitle:title];
    [self.navigationController pushViewController:investmentdetailsVC animated:YES];
}
-(void)jumpToSetGesturePwdFromVC:(UIViewController *)controler withGestureType:(GestureViewType)type :(void(^) ())resultCallBack
{
    SetGesturePwdVC *gestureVC = [[SetGesturePwdVC alloc] init];
    gestureVC.gestureType = type;
    [controler presentViewController:gestureVC animated:YES completion:^{
        resultCallBack();
    }];
}
/**
 金钱判断
 
 @param money 金额
 @return return value description
 */
-(NSString *)moneyStr:(NSInteger )money{
    if (@(money).floatValue > 10000) {
        float purchaseAmount = @(money).floatValue /10000;
        return [NSString stringWithFormat:@"%0.2f万",purchaseAmount];
    }else{
        return @(money).stringValue;
    }

}
/**
 预约金额
 
 @param moneyStr money description
 @return return value description
 */
-(NSString *)appointmentMoneyStr:(NSString *)moneyStr{
    float d = moneyStr.floatValue;
    return [NSString stringWithFormat:@"%0.2f",d];
}
/**
 手机号中间四位显示****
 
 @param phoneStr 手机号
 @return return value description
 */
-(NSString *)phone:(NSString *)phoneStr{
    if (phoneStr.length == 11) {
        NSString *newStr = phoneStr;
        NSString *numberString = [newStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return numberString;
    }else{
        return phoneStr;
    }
}
/**
 姓名加*
 
 @param nameStr 姓名
 @return return value description
 */
-(NSString *)name:(NSString *)nameStr{
    NSString *newStr = nameStr;
    
    NSString *numberString = [newStr stringByReplacingCharactersInRange:NSMakeRange(1, nameStr.length - 1) withString:@"**"];
    return numberString;
}

/**
 年化率百分比
 
 @param annualRateStr annualRateStr description
 @return return value description
 */
-(NSString *)annualRate:(NSString *)annualRateStr
{
    NSString *str = [NSString stringWithFormat:@"%.2f%@",annualRateStr.floatValue,@"%"];
    return str;
}
@end
