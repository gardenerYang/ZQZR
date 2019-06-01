//
//  CertificationViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "CertificationViewController.h"
#import "ZHLoginTextFieldTwoView.h"
#import "SuccessViewController.h"
#import "SkyerCityPicker.h"
#import "HttpRequest+my.h"
#import "BankCardViewController.h"
#import "NSString+Validation.h"
#import "AppUserProfile.h"
#import "MyModel.h"
@interface CertificationViewController ()

@property(nonatomic,strong)ZHLoginTextFieldTwoView *nameTextField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *cardTextField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *cityField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *addressField;

@property(nonatomic,strong)UIButton *selectCityBtn;

@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *bottomLine;
@property (strong, nonatomic) UIButton *confirmBtn;
@property(nonatomic,strong)UIView *middleLine;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)UIView *bottomLine1;


@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"实名认证"];
    [self addUI];
}
-(void)addUI{
    __weak typeof(self) wf = self;
    _nameTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _nameTextField.TextField.placeholder= @"真实姓名";
    _nameTextField.TextField.text = _myModel.realName.length == 0 ? @"" : _myModel.realName;

    _nameTextField.nameLb.text =  @"请输入真实姓名";
    _nameTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_nameTextField];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _cardTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _cardTextField.TextField.placeholder= @"身份证号";
    _cardTextField.TextField.text = _myModel.idNo.length == 0 ? @"" : _myModel.idNo;
    _cardTextField.nameLb.text =  @"请输入身份证号";
    _cardTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cardTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    [self.view addSubview:_cardTextField];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    
    
    _middleLine = [[UIView alloc]init];
    _middleLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_middleLine];
    NSString *cityStr = [NSString stringWithFormat:@"%@%@", _myModel.province,_myModel.city];
    _cityField=[[ZHLoginTextFieldTwoView alloc]init];
    _cityField.TextField.placeholder= @"请选择所在城市";
    _cityField.nameLb.text =  _myModel.province.length == 0 ? @"所在城市" : cityStr;
    _cityField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cityField.TextField.userInteractionEnabled = NO;
    [self.view addSubview:_cityField];
    
    
    
    _selectCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_selectCityBtn setImage:[UIImage imageNamed:@"selectCity_bottom"] forState:UIControlStateNormal];
    [_selectCityBtn addAction:^(UIButton *sender) {
        
        SkyerCityPicker *skyerCityPicker=[[SkyerCityPicker alloc] init];
        [skyerCityPicker cityPikerGetSelectCity:^(NSMutableDictionary *dicSelectCity) {
            NSLog(@"dicSelectCity=%@",dicSelectCity);
            NSString *cityText = [NSString stringWithFormat:@"%@%@%@",dicSelectCity[@"Province"],dicSelectCity[@"City"],dicSelectCity[@"District"]];
            wf.province = dicSelectCity[@"Province"];
            wf.city = dicSelectCity[@"City"];
            wf.cityField.TextField.text = cityText;
        }];
        
    }];
    [self.view addSubview:_selectCityBtn];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    _addressField=[[ZHLoginTextFieldTwoView alloc]init];
    _addressField.TextField.placeholder= @"请输入通讯地址";
    _addressField.nameLb.text = @"通讯地址";
    _addressField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_addressField];
    
    _bottomLine1 = [[UIView alloc]init];
    _bottomLine1.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine1];
    
    
    
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = kF18;
    _confirmBtn.layer.cornerRadius = 80/4;
    _confirmBtn.backgroundColor = kMainColor;
    [_confirmBtn addAction:^(UIButton *sender) {
        
        if (wf.nameTextField.TextField.text.length <= 0 ) {
            [MBProgressHUD showErrorMessage:@"请输入真实姓名"];
            return;
        }else if (wf.cardTextField.TextField.text.length <= 0){
            [MBProgressHUD showErrorMessage:@"请输入身份证号"];
            return;
        }else if (![wf.cardTextField.TextField.text validationType: ValidationTypeIDCard]){
            [MBProgressHUD showErrorMessage:@"输入的身份证号不正确"];
            return;
        }else if (wf.province.length <= 0){
            [MBProgressHUD showErrorMessage:@"请选择城市"];
            return;
        }else if (wf.addressField.TextField.text.length <= 0){
            [MBProgressHUD showErrorMessage:@"输入通讯地址"];
            return;
        }
        else{
            
        [MBProgressHUD showActivityMessageInView:nil];
        [HttpRequest getMyauthenticationUserName:wf.nameTextField.TextField.text idNum:wf.cardTextField.TextField.text province:wf.province city:wf.city contactAddress:wf.addressField.TextField.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
            [MBProgressHUD hideHUD];
            MyModel * model = [MyModel mj_objectWithKeyValues:data.data];
            [[AppUserProfile sharedInstance]saveidNo:wf.cardTextField.TextField.text];
            [[AppUserProfile sharedInstance]saveidrealName:wf.nameTextField.TextField.text];
            SuccessViewController *successVC=[[SuccessViewController alloc]init];
            successVC.titleLbText = @"认证成功";
            successVC.srcLbText = @"请绑定回款银行卡";
            successVC.btnTitle = @"下一步";
            successVC.btnBgColor = kMainColor;
            [successVC setTapBtnblock:^{
                BankCardViewController * BankCardVC = [[BankCardViewController alloc]init];
                [wf.navigationController pushViewController:BankCardVC animated:YES];
            }];
            [successVC showInVC:wf type:SuccessTypeBtn];
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            SuccessViewController *successVC=[[SuccessViewController alloc]init];
            successVC.titleLbText = @"认证失败";
            successVC.srcLbText = error.localizedDescription;
            successVC.btnTitle = @"返回";
            successVC.btnBgColor = kMainColor;
            successVC.imgName = @"err";
            [successVC setTapBtnblock:^{
                [successVC dismiss];
                [wf.navigationController popViewControllerAnimated:YES];
            }];
            [successVC showInVC:wf type:SuccessTypeBtn];

        }];
    }
        
    }];
    [self.view addSubview:_confirmBtn];
    
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.nameTextField);
        make.right.mas_equalTo(self.nameTextField);
        make.height.mas_equalTo(1);
    }];
    [self.cardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.topLine);
        make.right.mas_equalTo(self.topLine);
        make.height.mas_equalTo(self.nameTextField);
    }];
    
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cardTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.cardTextField);
        make.right.mas_equalTo(self.cardTextField);
        make.height.mas_equalTo(1);
    }];
    
    [self.cityField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.middleLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.middleLine);
        make.right.mas_equalTo(self.middleLine);
        make.height.mas_equalTo(60);
    }];
    [self.selectCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomLine.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(self.middleLine);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cityField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.cityField);
        make.right.mas_equalTo(self.cityField);
        make.height.mas_equalTo(1);
    }];
    
    [self.addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bottomLine);
        make.right.mas_equalTo(self.bottomLine);
        make.height.mas_equalTo(60);
    }];
    [self.bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.addressField);
        make.right.mas_equalTo(self.addressField);
        make.height.mas_equalTo(1);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine1.mas_bottom).offset(20);
        make.left.mas_equalTo(self.cardTextField).offset(10);
        make.right.mas_equalTo(self.cardTextField);
        make.height.mas_equalTo(80/2);
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
