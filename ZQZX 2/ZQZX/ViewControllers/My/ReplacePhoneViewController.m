//
//  ReplacePhoneViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ReplacePhoneViewController.h"
#import "ZHLoginTextFieldTwoView.h"
#import "RDCountDownButton.h"
#import "HttpRequest+my.h"
#import "SecuritySettingVC.h"
@interface ReplacePhoneViewController ()
@property(nonatomic,strong)ZHLoginTextFieldTwoView *phoneTextField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *verificationField;
@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *bottomLine;
@property (strong, nonatomic) RDCountDownButton *getCodeButton;
@property (strong, nonatomic) UILabel *stateLb;//状态提示label
@property (strong, nonatomic) UIButton *nextBtn;

@property (assign, nonatomic)  ReplacePhoneType type;

@end

@implementation ReplacePhoneViewController

- (instancetype)init:(ReplacePhoneType)type
{
    self = [super init]; //用于初始化父类
    if (self) {
        _type = type;
        [self addUI];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"更换手机号"];
}
-(void)addUI{
    
    __weak typeof(self) wf = self;
    
    _verificationField=[[ZHLoginTextFieldTwoView alloc]init];
    _verificationField.TextField.placeholder= _type == ReplacePhoneType_Code ? @"旧手机验证码" : @"新手机验证码";
    _verificationField.nameLb.text = @"验证码";
    _verificationField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verificationField.TextField.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:_verificationField];
    
    _getCodeButton = [RDCountDownButton buttonWithType:UIButtonTypeCustom];
    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeButton setTitleColor:kLightGray forState:UIControlStateNormal];
    _getCodeButton.titleLabel.font = [UIFont s14];
    _getCodeButton.layer.cornerRadius = 15.0;
    _getCodeButton.layer.borderColor = [UIColor m_textLighGrayColor].CGColor;
    _getCodeButton.layer.borderWidth = 1;
    [_getCodeButton addAction:^(UIButton *sender) {
      
      [wf getVerificationCode];
        
    }];
    [self.view addSubview:_getCodeButton];
    
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    _stateLb = [[UILabel alloc]init];
    _stateLb.font = [UIFont s12];
    _stateLb.text = @"";
    [self.view addSubview:_stateLb];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = kF18;
    _nextBtn.layer.cornerRadius = 80/4;
    _nextBtn.backgroundColor = kMainColor;
    if (_type == ReplacePhoneType_Code) {//如果是仅仅验证码时走
        [_nextBtn addAction:^(UIButton *sender) {
            if (wf.verificationField.TextField.text.length <= 0 ){
                [MBProgressHUD showErrorMessage:@"请输入验证码"];
                return;
            }
            [MBProgressHUD showActivityMessageInView:nil];

            [HttpRequest changePhoneNext:@"old" code:wf.verificationField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                 [MBProgressHUD hideHUD];
                    ReplacePhoneViewController *ReplacePhoneVC = [[ReplacePhoneViewController alloc]init:ReplacePhoneType_Phone_Code];
                    [wf.navigationController pushViewController:ReplacePhoneVC animated:YES];
            } failure:^(NSError * _Nonnull error) {
                 [MBProgressHUD showErrorMessage:error.localizedDescription];
            }];
         
            
        }];
    }else{
        [_nextBtn addAction:^(UIButton *sender) {
            if (wf.verificationField.TextField.text.length <= 0 ){
                [MBProgressHUD showErrorMessage:@"请输入验证码"];
                return;
            }
            [MBProgressHUD showActivityMessageInView:nil];
            [HttpRequest changePhoneNext:@"new" code:wf.verificationField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                [MBProgressHUD hideHUD];
                for (UIViewController *controller in wf.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[SecuritySettingVC class]]) {
                        [wf.navigationController popToViewController:controller animated:YES];
                    }
                }
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD showErrorMessage:error.localizedDescription];
            }];
        }];
    }
   
    [self.view addSubview:_nextBtn];
    
    
    
    if (_type == ReplacePhoneType_Phone_Code) {
        _phoneTextField=[[ZHLoginTextFieldTwoView alloc]init];
        _phoneTextField.TextField.placeholder= @"请输入新手机号码";
        _phoneTextField.nameLb.text = @"新手机号码";
        _phoneTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.TextField.keyboardType=UIKeyboardTypeNumberPad;
        [self.view addSubview:_phoneTextField];
        
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = [UIColor m_lineColor];
        [self.view addSubview:_topLine];
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
    }else{
        [self.verificationField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(60);
        }];
    }
    
    
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.verificationField.mas_bottom).offset(-10);
        make.right.mas_equalTo(self.verificationField);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verificationField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.verificationField);
        make.right.mas_equalTo(self.verificationField);
        make.height.mas_equalTo(1);
    }];
    
    [self.stateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.verificationField.mas_left).offset(10);
        make.right.mas_equalTo(self.verificationField);
        make.height.mas_equalTo(20);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stateLb.mas_bottom).offset(20);
        make.left.mas_equalTo(self.verificationField).offset(10);
        make.right.mas_equalTo(self.verificationField);
        make.height.mas_equalTo(80/2);
    }];
    
}


/**
 获取验证码
 */
-(void)getVerificationCode{
    if (self.type == ReplacePhoneType_Code) {//如果是仅仅验证码时走
        [HttpRequest changePhone:@"old" phone:@"" Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
            self.stateLb.text = [NSString stringWithFormat:@"发送短信成功"];
            [self countDownMethod];
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD showErrorMessage:error.localizedDescription];

        }];
        
    }else{
        if (self.phoneTextField.TextField.text.length <= 0 ) {
            [MBProgressHUD showErrorMessage:@"请输入手机号"];
            return;
        }
        [HttpRequest changePhone:@"old" phone:self.phoneTextField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
            self.stateLb.text = [NSString stringWithFormat:@"发送短信成功"];
            [self countDownMethod];
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD showErrorMessage:error.localizedDescription];
            
        }];
    }
}

/**
 验证码发送成功
 */
-(void)countDownMethod
{
    self.getCodeButton.enabled = NO;
    [self.getCodeButton startCountDownWithSecond:60];
    [_getCodeButton setTitleColor:kMainColor forState:UIControlStateNormal];
    _getCodeButton.layer.borderColor = kMainColor.CGColor;
    
    [self.getCodeButton countDownChanging:^NSString *(RDCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
        return title;
    }];
    [self.getCodeButton  countDownFinished:^NSString *(RDCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"重新获取";
        
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
