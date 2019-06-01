//
//  ActivityWebViewVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/4/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "ActivityWebViewVC.h"
#import "QYPublicBottomView.h"
#import "SuccessViewController.h"
@interface ActivityWebViewVC ()

@end

@implementation ActivityWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView setFrame:CGRectMake(0, 0, Iphonewidth, IphoneHight - NavHeight-StatusBarHight-50)];
    UIButton * leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:leftBtn];
    leftBtn.titleLabel.font = kFont(14);
    leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn setTitleColor:kSubtitleColor forState:(UIControlStateNormal)];
    [leftBtn setTitle:@"下次再说" forState:(UIControlStateNormal)];

    UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:rightBtn];
    rightBtn.titleLabel.font = kFont(14);
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setTitle:@"立即参加" forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:kMainColor forState:(UIControlStateNormal)];

    [rightBtn setFrame:CGRectMake(0, self.webView.bottom, kWidth/2, 50)];
    [leftBtn setFrame:CGRectMake(kWidth/2, self.webView.bottom, kWidth/2, 50)];
    
    //左右按钮互换位置
    [leftBtn addTapGestureBlock:^(UIView *view) {
        [self.navigationController popToRootViewControllerAnimated:YES];

    }];
    [rightBtn addTapGestureBlock:^(UIView *view) {
        [self requestParticipateActivity];

    }];
    leftBtn.layer.borderColor = kLightGray.CGColor;
    leftBtn.layer.borderWidth = 0.5f;
    rightBtn.layer.borderColor = kLightGray.CGColor;
    rightBtn.layer.borderWidth = 0.5f;
}
//请求参加活动
- (void)requestParticipateActivity{
    __weak typeof(self) wf = self;
    [HttpRequest post:activity_intoActivity param:@{@"investmentId":self.investmentId,@"activityId":self.activityId} success:^(HttpResponse *data, NSString *message) {
        [MBProgressHUD hideHUD];
        SuccessViewController *successVC=[[SuccessViewController alloc]init];
        successVC.titleLbText = @"参加成功";
        successVC.srcLbText = @"即将返回";
        [successVC setOtherblock:^{
            [wf.navigationController popToRootViewControllerAnimated:YES];
        }];
        [successVC showInVC:wf];
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];

    }];
}

@end
