//
//  LoginViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "LoginViewController.h"
#import "ZHLoginTextFieldView.h"
#import "ForgotPasswordViewController.h"
#import "RegisterViewController.h"
#import "HttpRequest+loginAndRegister.h"
#import "AppUserProfile.h"
#import "UIViewController+Util.h"
#import "NetworkManager+Base.h"
#if BusinessTag
#import "BusinessForgotPasswordViewController.h"
#else

#endif




@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *logoImg;
@property(nonatomic,strong)ZHLoginTextFieldView *phoneTextField;
@property(nonatomic,strong)ZHLoginTextFieldView *pwdTextField;
@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)UIButton *forgetBtn;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UILabel *registerLabel;




@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    [self setCustomerTitle:@"登录"];
       __weak typeof(self) wf = self;
#if BusinessTag
    [self setLeftBarButtonItemWithImg:@"back" selector:^(id sender) {
        UIViewController *vc = [UIViewController currentViewController];
        NSLog(@"%@",[vc class]);
        if ([ NSStringFromClass([vc class]) isEqual:@"ZHTabBarViewController"]) {
            [wf dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:Loginback object:nil];
        }
        else{
            [wf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
#else
    
#endif

    
  [self addUI];
}
-(void)addUI{
    __weak typeof(self) wf = self;

    _logoImg = [[UIImageView alloc]init];
    _logoImg.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:_logoImg];
    

    _phoneTextField=[[ZHLoginTextFieldView alloc]init];
    _phoneTextField.TextField.placeholder= @"请输入手机号码";
    _phoneTextField.TextFieldImageView.image=[UIImage imageNamed:@"login_phone"];
    _phoneTextField.TextField.clearButtonMode = UITextFieldViewModeNever;
    _phoneTextField.TextField.keyboardType=UIKeyboardTypeNumberPad;
    [_phoneTextField.TextField addTarget:self action:@selector(inputDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.view addSubview:_phoneTextField];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _pwdTextField=[[ZHLoginTextFieldView alloc]init];
    _pwdTextField.TextField.placeholder= @"请输入登录密码";
    _pwdTextField.TextFieldImageView.image=[UIImage imageNamed:@"login_pwd"];
    _pwdTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    [_pwdTextField isModifyFieldClearBtn];
    [self.view addSubview:_pwdTextField];
    [_pwdTextField addisHiddenBtn];
   
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    _forgetBtn.titleLabel.font = [UIFont s16];
    [_forgetBtn setTitleColor:[UIColor m_textGrayColor] forState:UIControlStateNormal];
    [_forgetBtn addAction:^(UIButton *sender) {
        
        
#if BusinessTag
        BusinessForgotPasswordViewController *forgotPasswordVC = [[BusinessForgotPasswordViewController alloc]init];
        [forgotPasswordVC setCustomerTitle:@"找回密码"];
        
        [wf.navigationController pushViewController:forgotPasswordVC animated:YES];
#else
        ForgotPasswordViewController *forgotPasswordVC = [[ForgotPasswordViewController alloc]init];
        [forgotPasswordVC setCustomerTitle:@"找回密码"];
        
        [wf.navigationController pushViewController:forgotPasswordVC animated:YES];
#endif
       
    }];
    [self.view addSubview:_forgetBtn];
    
    
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.backgroundColor = [UIColor m_Lightred];
    _loginBtn.titleLabel.font = [UIFont s20];
    _loginBtn.layer.cornerRadius = 25.0;
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.layer.shadowOffset =  CGSizeMake(1,10);
    _loginBtn.layer.shadowOpacity = 0.6;
    _loginBtn.layer.shadowColor =  [UIColor m_Lightred].CGColor;
    [_loginBtn addTarget:self action:@selector(gotoLoginClick) forControlEvents:UIControlEventTouchUpInside];
 
    [self.view addSubview:_loginBtn];
    
#if BusinessTag
    
#else
    
    _registerLabel = [[UILabel alloc] init];
    _registerLabel.textAlignment = NSTextAlignmentCenter;
    _registerLabel.font = [UIFont s14];
    _registerLabel.textColor=[UIColor m_textGrayColor];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"还没有注册会员？立即注册"];
    NSRange range1 = [[str string] rangeOfString:@"还没有注册会员？"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor m_textGrayColor] range:range1];
    NSRange range2 = [[str string] rangeOfString:@"立即注册"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor m_Lightred] range:range2];
    _registerLabel.attributedText=str;
    UITapGestureRecognizer* singleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer1.numberOfTapsRequired = 1;// 单击
    [_registerLabel addGestureRecognizer:singleRecognizer1];
    _registerLabel.userInteractionEnabled=YES;
    [self.view addSubview:_registerLabel];
    #endif
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImg.mas_bottom).offset(20);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.phoneTextField);
        make.right.mas_equalTo(self.phoneTextField);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(10);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.pwdTextField);
        make.right.mas_equalTo(self.pwdTextField);
        make.height.mas_equalTo(1);
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(10);
        make.right.mas_equalTo(self.bottomLine);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.forgetBtn.mas_bottom).offset(10);
        make.right.mas_equalTo(self.bottomLine);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(self.bottomLine);
    }];
#if BusinessTag
    
#else
    [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(30);
        make.right.mas_equalTo(self.bottomLine);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(self.bottomLine);
    }];
    
    #endif
    [self addBottomIMG];

}
/**
 开始登录
 */
-(void)gotoLoginClick{
    __weak typeof(self) wf = self;
    [self.phoneTextField.TextField resignFirstResponder];
    [self.pwdTextField.TextField resignFirstResponder];

    if (self.phoneTextField.TextField.text.length <= 0) {
        [MBProgressHUD showErrorMessage:@"请输入手机号"];
        return;
    }
//    NSString *pwd ;
//#if BusinessTag
//    pwd = @"888888";
//#else
//    pwd = @"123456";
//
//#endif
    [MBProgressHUD showActivityMessageInView:@"正在登录..."];

    [HttpRequest goToLogin:self.phoneTextField.TextField.text password:self.pwdTextField.TextField.text Requestsuccess:^(LoginModel *loginModel) {
        [MBProgressHUD hideHUD];
        if ([[AppUserProfile sharedInstance] saveUserInfoWithModel:loginModel]) {
            [wf dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"loginDidSuccess" object:nil];
            }];
        }else
        {
            NSLog(@"写入失败");
        }

    } failure:^(NSError * _Nonnull error) {

        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}

#pragma mark 快速注册
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (void)inputDidChange:(UITextField *)sender {
    if ([NetworkManager validatePhoneNumber:_phoneTextField.TextField.text]) {
        [_phoneTextField addCorrectImg];
        if (_phoneTextField.stateImg) {
            _phoneTextField.stateImg.hidden = NO;
        }
    }
    else{
        _phoneTextField.stateImg.hidden = YES;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
