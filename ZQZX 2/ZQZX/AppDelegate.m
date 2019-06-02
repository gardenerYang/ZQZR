//
//  AppDelegate.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHTabBarViewController.h"
#import "GesturePwdManageService.h"
#import "AppUserProfile.h"
#import "SetGesturePwdVC.h"
#import <Bugly/Bugly.h>
//#import "YSSafeFramework.h"
@interface AppDelegate ()<BuglyDelegate>
@property(nonatomic, strong) ZHTabBarViewController *mainController;
@property(nonatomic, strong) SetGesturePwdVC *gesturePwdVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:ZHMainType
                                               object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.mainController = [[ZHTabBarViewController alloc] initWithType];
    self.mainController.selectedIndex = 0;
    self.window.rootViewController = self.mainController;
    [self setKeyboard];
    //判断是否显示解锁页面
    [self setupBugly];
    [self showLockView];
    return YES;
}
//设置bugly
- (void)setupBugly {
    BuglyConfig * config = [[BuglyConfig alloc] init];
    config.debugMode = YES;
    config.blockMonitorEnable = YES;
    config.blockMonitorTimeout = 1.5;
    config.channel = @"Bugly";
    config.delegate = self;
    config.consolelogEnable = NO;
    config.viewControllerTrackingEnable = NO;
    [Bugly startWithAppId:@"642df93b8f"
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    [self performSelectorInBackground:@selector(testLogOnBackground) withObject:nil];
}
/**
 *    @brief TEST method for BuglyLog
 */
- (void)testLogOnBackground {
    int cnt = 0;
    while (1) {
        cnt++;
        switch (cnt % 5) {
            case 0:
                BLYLogError(@"Test Log Print %d", cnt);
                break;
            case 4:
                BLYLogWarn(@"Test Log Print %d", cnt);
                break;
            case 3:
                BLYLogInfo(@"Test Log Print %d", cnt);
                BLYLogv(BuglyLogLevelWarn, @"BLLogv: Test", NULL);
                break;
            case 2:
                BLYLogDebug(@"Test Log Print %d", cnt);
                BLYLog(BuglyLogLevelError, @"BLLog : %@", @"Test BLLog");
                break;
            case 1:
            default:
                BLYLogVerbose(@"Test Log Print %d", cnt);
                break;
        }
        
        // print log interval 1 sec.
        sleep(1);
    }
}
/**
 登录状态改变通知

 @param notification notification description
 */
- (void)loginStateChange:(NSNotification *)notification
{
    self.mainController = [[ZHTabBarViewController alloc] initWithType];
    self.mainController.selectedIndex = 0;
    self.window.rootViewController = self.mainController;
}


-(void)setKeyboard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
  
}
//显示解锁界面
-(void)showLockView
{
    //是否开启
    
    //时间间隔
    if ([AppUserProfile sharedInstance].isLogon) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        long long int Nowdate = (long long int)time;
        long long int dateTime =[[[AppUserProfile sharedInstance].customAttributes objectForKey:@"timegoBack"] longLongValue];
        BOOL timeTerm = Nowdate - dateTime >= 5;
        if ([GesturePwdManageService isSave] && timeTerm) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showGestureView];
            });
       }
//        else if ([GesturePwdManageService isSave] == NO)
//        {
//            [MBProgressHUD showErrorMessage:@"由于您手势密码未设置成功，已经将您退出登录"];
//            [GesturePwdManageService forgotPsw];
//            [[AppUserProfile sharedInstance] cleanUp];
//            if(self.window.rootViewController.presentedViewController)
//            {
//                [self.window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
//            }
//        }
    }
    //是否开启指纹密码
    
}
//显示手势解锁界面
-(void)showGestureView
{
    _gesturePwdVC = [[SetGesturePwdVC alloc] init];
    _gesturePwdVC.gestureType = ValidateGesturePwdType;
    
    //    //如果已经present一个VC，先要dismiss才能显示手势密码
    //    if(self.window.rootViewController.presentedViewController)
    //    {
    //        [self.window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    //    }
    
    [self.window.rootViewController presentViewController:_gesturePwdVC animated:NO completion:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
