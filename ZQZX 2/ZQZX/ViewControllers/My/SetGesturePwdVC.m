//
//  SetGesturePwdVC.m
//  ZQZX
//
//  Created by 中企 on 2018/10/30.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "SetGesturePwdVC.h"
#import "AliPayViews.h"
#import "GesturePwdManageService.h"
#import "HttpRequest+my.h"
#import "AppUserProfile.h"
@interface SetGesturePwdVC ()
/**
 *  背景渐变色
 */
@property (strong, nonatomic) CAGradientLayer *backgroundGradient;
@end

@implementation SetGesturePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //背景渐变
    _backgroundGradient = [CAGradientLayer layer];
    
    
    UIColor *startColor = [UIColor m_red];
    UIColor *endColor = [UIColor m_blue];
    
    _backgroundGradient.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    _backgroundGradient.startPoint = CGPointMake(0, 1);
    _backgroundGradient.endPoint = CGPointMake(0, 0);
    _backgroundGradient.frame = self.view.frame;
    [self.view.layer addSublayer:_backgroundGradient];
    
    /************************* start **********************************/
    
    BOOL backBtnNeedHidden = NO;
    
    AliPayViews *alipay = [[AliPayViews alloc] initWithFrame:self.view.bounds];
    switch (_gestureType) {
        case EditGesturePwdType:
            alipay.gestureModel = AlertPwdModel;
            break;
        case ResetGesturePwdType:
        {
            alipay.gestureModel = SetPwdModel;
            backBtnNeedHidden = YES;
        }
            break;
        case ValidateGesturePwdType:
        {
            alipay.gestureModel = ValidatePwdModel;
            backBtnNeedHidden = YES;
        }
            break;
        case DeleteGesturePwdType:
            alipay.gestureModel = DeletePwdModel;
            break;
        case NoneType:
            alipay.gestureModel = NoneModel;
        default:
            break;
    }
    
    
    alipay.AliPayViewsBlcok = ^(Blocktype type) {
        
        if (type == success) {
            
            if (self.gestureType == ValidateGesturePwdType) {
//                //验证手势密码成功后 刷新token
//                [self refreshUserToken];
             [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        else if (type == failed || type == failedcount || type == changeAccount)
        {
            //clear 用户信息，但不clear 手势密码
            //发送通知
            if (type == failedcount) {
                [GesturePwdManageService forgotPsw];
            }
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_USERLOGOUT object:nil ];
            [self gotoQuit];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else if (type == forgetPwd)
        {
            [GesturePwdManageService forgotPsw];
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_USERLOGOUT object:nil ];
            [self gotoQuit];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    };
    [self.view addSubview:alipay];
    
    
    /************************* end **********************************/
    float topHeight = self.view.frame.size.height == 812.0 ? 24.0 : 0.0;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, topHeight, 64, 64);
    backBtn.hidden = backBtnNeedHidden;
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

/**
 *  刷新用户token
 */
-(void)refreshUserToken
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [SVProgressHUD showWithStatus:@"请稍后"];
//    [UserService refreshTokenResultCallBack:^(DoLoginModel *reslutModel , RdAppError *error) {
//
//        if (error.errCode == RdAppErrorTypeSuccess) {
//            [SVProgressHUD dismiss];
//            [P2PAccountService saveUserInfoWithModel:reslutModel];
//
//        }
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
    
}
-(void)gotoQuit{
    [HttpRequest exitLogonRequestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
        [[AppUserProfile sharedInstance]cleanUp];

        [[NSNotificationCenter defaultCenter] postNotificationName:ZHMainType object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:goToLoginState object:nil];
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}
- (void)back  {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
