//
//  RegisterNextViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/11.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "RegisterNextViewController.h"
#import "ZHLoginTextFieldView.h"
#import "HttpRequest+loginAndRegister.h"
#import "TipsViewController.h"
@interface RegisterNextViewController ()
@property(nonatomic,strong)UILabel *srcLb;
@property(nonatomic,strong)ZHLoginTextFieldView *pwdTextField;
@property(nonatomic,strong)ZHLoginTextFieldView *pwdTwoField;
@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)UIButton *nextBtn;
@end

@implementation RegisterNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupForDismissKeyboard];
    [self setCustomerTitle:@"注册"];

    [self addUI];
}
-(void)addUI{
    __weak typeof(self) wf = self;

    _srcLb = [[UILabel alloc]init];
    _srcLb.text = @"设置登录密码";
    _srcLb.font = [UIFont boldSystemFontOfSize:22];
    _srcLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_srcLb];
    
    _pwdTextField=[[ZHLoginTextFieldView alloc]init];
    _pwdTextField.TextField.placeholder= @"请输入登录密码";
    _pwdTextField.TextFieldImageView.image=[UIImage imageNamed:@"login_pwd"];
    _pwdTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    _pwdTextField.TextField.secureTextEntry = YES;
    [self.view addSubview:_pwdTextField];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _pwdTwoField=[[ZHLoginTextFieldView alloc]init];
    _pwdTwoField.TextField.placeholder= @"请再次输入登录密码";
    _pwdTwoField.TextFieldImageView.image=[UIImage imageNamed:@"login_pwd"];
    _pwdTwoField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTwoField.TextField.keyboardType=UIKeyboardTypeDefault;
    _pwdTwoField.TextField.secureTextEntry = YES;
    [self.view addSubview:_pwdTwoField];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
   
    
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setTitle:@"注册" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = kMainColor;
    _nextBtn.titleLabel.font = kF18;
    _nextBtn.layer.cornerRadius = 80/4;
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.layer.shadowOffset =  CGSizeMake(1,10);
    _nextBtn.layer.shadowOpacity = 0.6;
    _nextBtn.layer.shadowColor =  kMainColor.CGColor;
    [_nextBtn addAction:^(UIButton *sender) {
        [wf.pwdTextField.TextField resignFirstResponder];
        [wf.pwdTwoField.TextField resignFirstResponder];

        if (self.pwdTextField.TextField.text.length <= 0 ) {
            [MBProgressHUD showErrorMessage:@"请输入登录密码"];
            return;
        }else if (self.pwdTwoField.TextField.text.length <= 0 ){
            [MBProgressHUD showErrorMessage:@"请再次输入登录密码"];
            return;
        }else if (![wf.pwdTwoField.TextField.text isEqual:wf.pwdTextField.TextField.text ] ){
            wf.pwdTextField.TextField.text = @"";
            [MBProgressHUD showErrorMessage:@"两次输入密码不一致"];
            return;
        }else if (wf.pwdTwoField.TextField.text.length < 8 ||wf.pwdTwoField.TextField.text.length >20 ){
            wf.pwdTextField.TextField.text = @"";
            wf.pwdTwoField.TextField.text = @"";
            [MBProgressHUD showErrorMessage:@"请输入8-20位的密码"];
            return;
        }else{
            [MBProgressHUD showActivityMessageInView:nil];

            [HttpRequest registration:wf.phone fpName:wf.recommendCode password:wf.pwdTwoField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                [MBProgressHUD hideHUD];
                TipsViewController *TipsVC=[[TipsViewController alloc]init];
                TipsVC.titleLbText = @"温馨提示";
                TipsVC.srcLbText = @"注册成功,是否去登录";
                [TipsVC setTapCancelBtnblock:^{
                    
                }];
                [TipsVC setTapConfirmBtnblock:^{
                    [wf.navigationController popToRootViewControllerAnimated:YES];
                }];
                [TipsVC showInVC: wf ];

            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD showErrorMessage:error.localizedDescription];
            }];
        }

    }];
    [self.view addSubview:_nextBtn];
    [self.srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(loginsLeftSpacing);
        make.right.mas_equalTo(loginsRightSpacing);
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.srcLb.mas_bottom).offset(20);
        make.left.mas_equalTo(self.srcLb);
        make.right.mas_equalTo(self.srcLb);
        make.height.mas_equalTo(60);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.pwdTextField);
        make.right.mas_equalTo(self.pwdTextField);
        make.height.mas_equalTo(1);
    }];
    [self.pwdTwoField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.topLine);
        make.right.mas_equalTo(self.topLine);
        make.height.mas_equalTo(60);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdTwoField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.pwdTwoField);
        make.right.mas_equalTo(self.pwdTwoField);
        make.height.mas_equalTo(1);
    }];

    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(20);
        make.right.mas_equalTo(self.topLine);
        make.height.mas_equalTo(80/2);
        make.left.mas_equalTo(self.topLine);
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
