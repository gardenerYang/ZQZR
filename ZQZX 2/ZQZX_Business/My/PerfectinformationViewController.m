//
//  PerfectinformationViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/11/3.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "PerfectinformationViewController.h"
#import "ZHLoginTextFieldTwoView.h"
#import "SkyerCityPicker.h"
#import "CityPickerViewController.h"
#import "HttpRequest+MyBusiness.h"
#import "SuccessViewController.h"
@interface PerfectinformationViewController ()
@property(nonatomic,strong)ZHLoginTextFieldTwoView *nameTextField;
@property(nonatomic,strong)ZHLoginTextFieldTwoView *cardTextField;
@property(nonatomic,strong)UIView *topLine;
@property(nonatomic,strong)UIView *bottomLine;
@property (strong, nonatomic) UIButton *confirmBtn;
@property(nonatomic,strong)NSString *cityStr;//市
@property(nonatomic,strong)NSString *provinceStr;//省
@property(nonatomic,strong)UIButton *selectCityBtn;

@end

@implementation PerfectinformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"完善信息"];
    [self addUI];
}
-(void)addUI{
    __weak typeof(self) wf = self;
    
    
    
    _nameTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _nameTextField.TextField.placeholder= @"我的邮箱";
//    _nameTextField.TextField.text = wf.myModel.realName.length <=0 ?  @"" : wf.myModel.realName;
    _nameTextField.nameLb.text = @"我的邮箱" ;
    _nameTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    _nameTextField.TextField.text = _myModel.email;
    [self.view addSubview:_nameTextField];
    
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_topLine];
    
    _cardTextField=[[ZHLoginTextFieldTwoView alloc]init];
    _cardTextField.TextField.placeholder= @"所在城市";
    _cardTextField.nameLb.text = @"您的所在城市";
    _cardTextField.TextField.text = _myModel.province;

    _cardTextField.TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _cardTextField.TextField.keyboardType=UIKeyboardTypeDefault;
    _cardTextField.TextField.userInteractionEnabled = NO;
    [self.view addSubview:_cardTextField];
    
    _bottomLine = [[UIView alloc]init];
    _bottomLine.backgroundColor = [UIColor m_lineColor];
    [self.view addSubview:_bottomLine];
    
    
    _selectCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_selectCityBtn setImage:[UIImage imageNamed:@"selectCity_bottom"] forState:UIControlStateNormal];
    [_selectCityBtn addAction:^(UIButton *sender) {
        
        SkyerCityPicker *skyerCityPicker=[[SkyerCityPicker alloc] init];
        [skyerCityPicker cityPikerGetSelectCity:^(NSMutableDictionary *dicSelectCity) {
            NSLog(@"dicSelectCity=%@",dicSelectCity);
            NSString *cityText = [NSString stringWithFormat:@"%@%@%@",dicSelectCity[@"Province"],dicSelectCity[@"City"],dicSelectCity[@"District"]];
            wf.cityStr = dicSelectCity[@"City"];
            wf.provinceStr = dicSelectCity[@"Province"];
            wf.cardTextField.TextField.text = cityText;
        }];
        
    }];
    [self.view addSubview:_selectCityBtn];
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont s20];
    _confirmBtn.layer.cornerRadius = 25.0;
    _confirmBtn.backgroundColor = [UIColor m_red];
    [_confirmBtn addAction:^(UIButton *sender) {
        [MBProgressHUD showActivityMessageInView:nil];
        if (wf.nameTextField.TextField.text.length == 0) {
            [MBProgressHUD showErrorMessage:@"请输入您的邮箱"];
            return ;
        }else if (wf.cardTextField.TextField.text.length == 0){
            [MBProgressHUD showErrorMessage:@"请选择您的所在地"];
            return ;
        }
        else{
        [wf.nameTextField.TextField resignFirstResponder];
        [HttpRequest updateFinancialPlannerInfoID:@"" corpId:@"" employeesNo:@"" password:@"" username:@"" realname:@"" phone:@"" email:wf.nameTextField.TextField.text rate:@"" level:@"" levelName:@"" province:wf.provinceStr city:wf.cityStr status:@"" addTime:@"" addIp:@"" superiorId:@"" superiorName:@"" referralCode:@"" headImageUrl:@"" Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
            [MBProgressHUD hideHUD];
            SuccessViewController *successVC=[[SuccessViewController alloc]init];
            successVC.titleLbText = @"提交成功";
            successVC.srcLbText = @"即将返回";
            [successVC setOtherblock:^{
                [wf.navigationController popViewControllerAnimated:YES];
            }];
            [successVC showInVC:wf];

        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD showErrorMessage:error.localizedDescription];

        }];;
        
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
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cardTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.cardTextField);
        make.right.mas_equalTo(self.cardTextField);
        make.height.mas_equalTo(1);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bottomLine);
        make.right.mas_equalTo(self.bottomLine);
        make.height.mas_equalTo(50);
    }];

    [self.selectCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomLine.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(self.topLine);
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
