//
//  InvestorConfirmation.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/23.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "InvestorConfirmation.h"
#import "RiskPopWindowView.h"
#import "AppUserProfile.h"
@interface InvestorConfirmation ()
@property (nonatomic,strong)RiskPopWindowView * popView;
@property (nonatomic,strong)UIView * shadeView;
@property (nonatomic,strong)UIView * bgView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *promiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *investorBtn;
@property (nonatomic,assign) BOOL isInvestor;
@property (nonatomic,assign) BOOL isPromise;
@end

@implementation InvestorConfirmation

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.promiseBtn setImage:kImageNamed(@"unchecked.png") forState:(UIControlStateNormal)];
    [self.promiseBtn setImage:kImageNamed(@"checked.png") forState:(UIControlStateSelected)];

    [self.promiseBtn addTapGestureBlock:^(UIView *view) {
        self.promiseBtn.selected = !self.promiseBtn.selected;
        self.isPromise = self.promiseBtn.selected;
    }];
    [self.investorBtn addTapGestureBlock:^(UIView *view) {
        [UIView animateWithDuration:0.3 animations:^{
            self.shadeView.alpha = .5;
            self.bgView.alpha = 1;
            self.shadeView.hidden = NO;
            self.bgView.hidden = NO;
        }];
    }];
    
    [self createShadeView];
    [self.doneBtn addTapGestureBlock:^(UIView *view) {
        if (!self.isInvestor) {
            [MBProgressHUD showErrorMessage:@"请阅读并同意风险揭示书"];
            return ;
        }
        if (!self.isPromise) {
            [MBProgressHUD showErrorMessage:@"请勾选承诺述合格投资者条件"];
            return ;
        }
        [MBProgressHUD showActivityMessageInView:@"正在提交..."];
        [HttpRequest post:my_investorConfirm param:@{@"userId":[AppUserProfile sharedInstance].userId} success:^(HttpResponse *data, NSString *message) {
            [MBProgressHUD showSuccessMessage:@"提交成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"InvestorConfirmationSuccess" object:nil];
        } failure:^(NSError *error) {
            [MBProgressHUD showErrorMessage:@"提交失败"];
        }];
    }];
    
}
- (void)createShadeView{
    self.shadeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.shadeView.backgroundColor = [UIColor blackColor];
    self.shadeView.alpha = 0.5f;
    [kWindow addSubview:self.shadeView];
    self.shadeView.alpha = 0;
    self.shadeView.hidden = YES;
    self.popView = [[[NSBundle mainBundle]loadNibNamed:@"RiskPopWindowView" owner:self options:0]lastObject];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(12, 50, kWidth-24, kHeight - 120)];
    self.bgView = view;
    [kWindow addSubview:self.bgView];
    [self.bgView addSubview:self.popView];
    [self.popView setFrame:self.bgView.bounds];
    self.bgView.alpha = 0;
    self.bgView.hidden = YES;
    [self.popView.doneBtn addTapGestureBlock:^(UIView *view) {
        [UIView animateWithDuration:0.3 animations:^{
            self.shadeView.alpha = 0.0;
            self.bgView.alpha = 0;
        } completion:^(BOOL finished) {
            self.shadeView.hidden = YES;
            self.bgView.hidden = YES;
            self.isInvestor = YES;
        }];
    }];
    [self.popView.cancelBtn addTapGestureBlock:^(UIView *view) {
        [UIView animateWithDuration:0.3 animations:^{
            self.shadeView.alpha = 0.0;
            self.bgView.alpha = 0;
        } completion:^(BOOL finished) {
            self.shadeView.hidden = YES;
            self.bgView.hidden = YES;
        }];

    }];
}
@end
