//
//  ForgotPasswordNextViewControllerViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/11.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ForgotPasswordNextViewController.h"
#import "ZHLoginTextFieldTwoView.h"
#import "SuccessViewController.h"
#import "HttpRequest+loginAndRegister.h"
@interface ForgotPasswordNextViewController ()
@property(nonatomic,strong)ZHLoginTextFieldTwoView *phoneTextField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *verificationField;
@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *bottomLine;
@property (strong, nonatomic) UIButton *confirmBtn;
@end

@implementation ForgotPasswordNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupForDismissKeyboard];

    [self setCustomerTitle:@"修改密码"];
    [self addUI];
}
-(void)addUI{
    
    __weak typeof(self) wf = self;

    _phoneTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _phoneTextField.TextField.placeholder= @"设置新的密码";
    _phoneTextField.nameLb.text = @"请输入新的密码";
    _phoneTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    _phoneTextField.TextField.secureTextEntry = YES;
    [self.view addSubview:_phoneTextField];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _verificationField=[[ZHLoginTextFieldTwoView alloc]init];
    _verificationField.TextField.placeholder= @"再次输入新密码";
    _verificationField.nameLb.text = @"请再次输入新密码";
    _verificationField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verificationField.TextField.keyboardType=UIKeyboardTypeDefault;
    _verificationField.TextField.secureTextEntry = YES;
    [self.view addSubview:_verificationField];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont s20];
    _confirmBtn.layer.cornerRadius = 25.0;
    _confirmBtn.backgroundColor = [UIColor m_red];
    [_confirmBtn addAction:^(UIButton *sender) {

        
        if (self.phoneTextField.TextField.text.length <= 0 ) {
            [MBProgressHUD showErrorMessage:@"请输入登录密码"];
            return;
        }else if (self.verificationField.TextField.text.length <= 0 ){
            [MBProgressHUD showErrorMessage:@"请再次输入登录密码"];
            return;
        }else if (![wf.phoneTextField.TextField.text isEqual:wf.verificationField.TextField.text ] ){
            wf.verificationField.TextField.text = @"";
            [MBProgressHUD showErrorMessage:@"两次输入密码不一致"];
            return;
        }else if (wf.verificationField.TextField.text.length < 8 ||wf.verificationField.TextField.text.length >20 ){
            wf.verificationField.TextField.text = @"";
            wf.phoneTextField.TextField.text = @"";
            [MBProgressHUD showErrorMessage:@"请输入8-20位的密码"];
            return;
        }
        else{
            [MBProgressHUD showActivityMessageInView:nil];
            [HttpRequest forgetPasswordSubmission:wf.phone password:wf.phoneTextField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                [MBProgressHUD hideHUD];
                SuccessViewController *successVC=[[SuccessViewController alloc]init];
                successVC.titleLbText = @"密码重置成功";
                successVC.srcLbText = @"即将跳转登录页";
                [successVC showInVC:wf];
                [successVC setOtherblock:^{
                    [successVC dismiss];
                    [wf.navigationController popToRootViewControllerAnimated:YES];
                }];
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD showErrorMessage:error.localizedDescription];
            }];
        }
        
        

    }];
    [self.view addSubview:_confirmBtn];
    
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
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
    [self.verificationField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.topLine);
        make.right.mas_equalTo(self.topLine);
        make.height.mas_equalTo(self.phoneTextField);
    }];
    
    
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verificationField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.verificationField);
        make.right.mas_equalTo(self.verificationField);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(20);
        make.left.mas_equalTo(self.verificationField).offset(10);
        make.right.mas_equalTo(self.verificationField);
        make.height.mas_equalTo(50);
    }];
    
    [self addBottomIMG];

    
    
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
