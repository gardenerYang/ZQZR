//
//  RegisterViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/11.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "RegisterViewController.h"
#import "ZHLoginTextFieldView.h"
#import "RDCountDownButton.h"
#import "RegisterNextViewController.h"
#import "ApplyViewController.h"
#import "HttpRequest+loginAndRegister.h"
#import "URLManage.h"
@interface RegisterViewController ()
@property(nonatomic,strong)UILabel *srcLb;
@property(nonatomic,strong)ZHLoginTextFieldView *phoneTextField;
@property(nonatomic,strong)ZHLoginTextFieldView *referralField;
@property(nonatomic,strong)ZHLoginTextFieldView *verificationField;
@property(nonatomic,strong)UIButton *applyBtn;
@property (strong, nonatomic) RDCountDownButton *getCodeButton;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UILabel *registerLabel;
@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *middleLine;
@property(nonatomic,strong)UIView *bottomLine;

@property(nonatomic,strong)UIView *Line;

@end

@implementation RegisterViewController

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
    _srcLb.text = @"欢迎加入永业通";
    _srcLb.font = [UIFont boldSystemFontOfSize:22];
    _srcLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_srcLb];
    
    _phoneTextField=[[ZHLoginTextFieldView alloc]init];
    _phoneTextField.TextField.placeholder= @"请输入手机号码";
    _phoneTextField.TextFieldImageView.image=[UIImage imageNamed:@"login_phone"];
    _phoneTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextField.TextField.keyboardType=UIKeyboardTypeNumberPad;
    [_phoneTextField.TextField addTarget:self action:@selector(inputDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField isModifyFieldClearBtn];

    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _referralField=[[ZHLoginTextFieldView alloc]init];
    _referralField.TextField.placeholder= Iphonewidth == 320 || Iphonewidth == 375 ? @"理财师推荐码" : @"请输入理财师推荐码";
    _referralField.TextFieldImageView.image=[UIImage imageNamed:@"Invitation"];
    _referralField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _referralField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_referralField];
    [_referralField isModifyFieldClearBtn];

    _middleLine = [[UIView alloc]init];
    _middleLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_middleLine];
    
    _verificationField=[[ZHLoginTextFieldView alloc]init];
    _verificationField.TextField.placeholder= @"请输入验证码";
    _verificationField.TextFieldImageView.image=[UIImage imageNamed:@"verification"];
    _verificationField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verificationField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_verificationField];
    [_verificationField isModifyFieldClearBtn];

    _Line = [[UIView alloc]init];
    _Line.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_Line];
    
    
    _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_applyBtn setTitle:@"申请理财师" forState:UIControlStateNormal];
    _applyBtn.titleLabel.font = [UIFont s16];
    [_applyBtn setTitleColor:[UIColor m_Lightred] forState:UIControlStateNormal];
    [_applyBtn addAction:^(UIButton *sender) {
        ApplyViewController *applyVC = [[ApplyViewController alloc]init];
        [wf.navigationController pushViewController:applyVC animated:YES];
    }];
    [self.view addSubview:_applyBtn];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    
    _getCodeButton = [RDCountDownButton buttonWithType:UIButtonTypeCustom];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeButton setTitleColor:[UIColor m_textGrayColor] forState:UIControlStateNormal];
    _getCodeButton.titleLabel.font = [UIFont s14];
    _getCodeButton.layer.cornerRadius = 15.0;
    _getCodeButton.layer.borderColor = [UIColor m_textLighGrayColor].CGColor;
    _getCodeButton.layer.borderWidth = 1;
    [_getCodeButton addAction:^(UIButton *sender) {
        if (self.phoneTextField.TextField.text.length <= 0 ) {
            [MBProgressHUD showErrorMessage:@"请输入手机号"];
            return;
        }else if (![NetworkManager validatePhoneNumber:wf.phoneTextField.TextField.text]){
            [MBProgressHUD showErrorMessage:@"手机号格式错误"];
        }else if (self.referralField.TextField.text.length <= 0 ) {
            [MBProgressHUD showErrorMessage:@"请输入理财师推荐码"];
            return;
        }
        else
        {
            [wf getVerificationCode];
        }
    }];
    [self.view addSubview:_getCodeButton];

    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setImage:[UIImage imageNamed:@"select_a"] forState:UIControlStateNormal];
    [_selectBtn addAction:^(UIButton *sender) {
        
        if (wf.selectBtn.selected) {
            wf.selectBtn.selected = false;
            [wf.selectBtn setImage:[UIImage imageNamed:@"select_a"] forState:UIControlStateNormal];

        }else{
            wf.selectBtn.selected = YES;
            [wf.selectBtn setImage:[UIImage imageNamed:@"select_b"] forState:UIControlStateNormal];
        }
    }];
    [self.view addSubview:_selectBtn];
    
    
    _registerLabel = [[UILabel alloc] init];
    _registerLabel.textAlignment = NSTextAlignmentLeft;
    _registerLabel.font = [UIFont s14];
    _registerLabel.textColor=[UIColor m_textGrayColor];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"我已经阅读并同意《用户注册协议》"];
    NSRange range1 = [[str string] rangeOfString:@"我已经阅读并同意"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor m_textGrayColor] range:range1];
    NSRange range2 = [[str string] rangeOfString:@"《用户注册协议》"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor m_blue] range:range2];
    _registerLabel.attributedText=str;
    UITapGestureRecognizer* singleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer1.numberOfTapsRequired = 1;// 单击
    [_registerLabel addGestureRecognizer:singleRecognizer1];
    _registerLabel.userInteractionEnabled=YES;
    [self.view addSubview:_registerLabel];
    
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = [UIColor m_Lightred];
    _nextBtn.titleLabel.font = [UIFont s20];
    _nextBtn.layer.cornerRadius = 25.0;
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.layer.shadowOffset =  CGSizeMake(1,10);
    _nextBtn.layer.shadowOpacity = 0.6;
    _nextBtn.layer.shadowColor =  [UIColor m_Lightred].CGColor;
    [_nextBtn addTarget:self action:@selector(netBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
    [self.srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(loginsLeftSpacing);
        make.right.mas_equalTo(loginsRightSpacing);
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.srcLb.mas_bottom).offset(20);
        make.left.mas_equalTo(self.srcLb);
        make.right.mas_equalTo(self.srcLb);
        make.height.mas_equalTo(60);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.phoneTextField);
        make.right.mas_equalTo(self.phoneTextField);
        make.height.mas_equalTo(1);
    }];
    [self.referralField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.topLine);
        make.right.mas_equalTo(self.topLine.mas_right).offset(-110);
        make.height.mas_equalTo(60);
    }];
    
    [self.Line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.referralField.mas_top).offset(15);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(self.applyBtn.mas_left).offset(-10);
        make.bottom.mas_equalTo(self.referralField.mas_bottom).offset(-15);
    }];
    
    
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.referralField);
        make.width.mas_equalTo(100);
        make.right.mas_equalTo(self.topLine.mas_right);
        make.height.mas_equalTo(60);
    }];
    
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.referralField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.topLine);
        make.right.mas_equalTo(self.topLine);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.verificationField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middleLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.middleLine);
        make.right.mas_equalTo(self.middleLine.mas_right).offset(-110);
        make.height.mas_equalTo(60);
    }];
    
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.verificationField);
        make.width.mas_equalTo(100);
        make.right.mas_equalTo(self.topLine.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verificationField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.topLine);
        make.right.mas_equalTo(self.verificationField);
        make.height.mas_equalTo(1);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(20);
        make.left.mas_equalTo(self.topLine);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selectBtn);
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(10);
        make.right.mas_equalTo(self.topLine);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registerLabel.mas_bottom).offset(20);
        make.right.mas_equalTo(self.topLine);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(self.topLine);
    }];
    [self addBottomIMG];

}
#pragma mark 用户协议
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    [self gotoWebURL:[URLManage urlWithAPI:user_serviceAgreement] title:@"用户注册协议"];
}
#pragma mark 下一步

-(void)netBtnClick{
  
    if (self.phoneTextField.TextField.text.length <= 0 ) {
        [MBProgressHUD showErrorMessage:@"请输入手机号"];
        return;
    }else if (![NetworkManager validatePhoneNumber:_phoneTextField.TextField.text]){
        [MBProgressHUD showErrorMessage:@"手机号格式错误"];
        return;
    }else if (self.referralField.TextField.text.length <= 0 ){
        [MBProgressHUD showErrorMessage:@"请输入理财师推荐码"];
        return;
    }else if (self.verificationField.TextField.text.length <= 0 ){
        [MBProgressHUD showErrorMessage:@"请输入验证码"];
        return;
    }else if (self.verificationField.TextField.text.length > 6 ){
        self.verificationField.TextField.text = @"";
        [MBProgressHUD showErrorMessage:@"验证码输入有误"];
        return;
    }else{
        if (!_selectBtn.selected) {
            [MBProgressHUD showErrorMessage:@"请阅读并同意用户协议"];
        }
        else{//
            [MBProgressHUD showActivityMessageInView:nil];
            [HttpRequest registrationNextStep:_phoneTextField.TextField.text code:_verificationField.TextField.text fpName:self.referralField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                [MBProgressHUD hideHUD];
                RegisterNextViewController *registerNextVC = [[RegisterNextViewController alloc]init];
                registerNextVC.recommendCode = self.referralField.TextField.text;
                registerNextVC.phone = self.phoneTextField.TextField.text;
                [self.navigationController pushViewController:registerNextVC animated:YES];
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD showErrorMessage:error.localizedDescription];

            }];
        }
    }
    
  
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

/**
 验证码发送成功
 */
-(void)countDownMethod
{
        self.getCodeButton.enabled = NO;
        [self.getCodeButton startCountDownWithSecond:60];
        [_getCodeButton setTitleColor:[UIColor m_red] forState:UIControlStateNormal];
        _getCodeButton.layer.borderColor = [UIColor m_Lightred].CGColor;
        
        [self.getCodeButton countDownChanging:^NSString *(RDCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [self.getCodeButton  countDownFinished:^NSString *(RDCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新获取";
            
        }];
}
-(void)getVerificationCode{
    [HttpRequest getVerificationCodePhone:_phoneTextField.TextField.text fpName:_referralField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
        [MBProgressHUD showSuccessMessage:message];
        [self countDownMethod];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];

    }];
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
