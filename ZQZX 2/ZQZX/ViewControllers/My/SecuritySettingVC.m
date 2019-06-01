//
//  SecuritySettingVC.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "SecuritySettingVC.h"
#import "MyTableViewCell.h"
#import "ZHSwitch.h"
#import "ReplacePhoneViewController.h"
#import "ForgotPasswordViewController.h"
#import "GesturePwdManageService.h"
#import "BusinessReplacePhoneVC.h"
#if BusinessTag
#import "BusinessForgotPasswordViewController.h"

#else

#endif
@interface SecuritySettingVC ()
@property(nonatomic,strong)  NSArray *titleArr;

@end

@implementation SecuritySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"设置"] ;
    _titleArr = [NSArray arrayWithObjects:@"手势密码开关",@"修改登录密码",@"更换手机号", nil];
    
    [self addUI];
}
-(void)addUI{
    
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    MyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier type:cellTypeDefault];
    }
    cell.titleLb.text = _titleArr[indexPath.row];
    if (indexPath.row == 0 ) {
        ZHSwitch *switchView=[[ZHSwitch alloc]initWithFrame:CGRectMake(Iphonewidth-100, 10, 60, 40)];
        [switchView setOn:[GesturePwdManageService isSave] animated:NO];
        [switchView addTarget:self action:@selector(respondsToSwitchAction:) forControlEvents:UIControlEventValueChanged];
        switchView.onTintColor = kMainColor;
        [cell addSubview:switchView];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    return cell;
    
}
- (void)respondsToSwitchAction:(ZHSwitch *)sender {
    
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
        //根据userId 判断该用户是否在本机上设置过手势密码
        if (![GesturePwdManageService isSave]) {
            
            [self jumpToSetGesturePwdFromVC:self withGestureType:ResetGesturePwdType :^{
                
            }];
        }
    }else {
        NSLog(@"关");
        [GesturePwdManageService forgotPsw];
    }
    
}
//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
#if BusinessTag
        BusinessForgotPasswordViewController *ForgotPasswordVC =[[BusinessForgotPasswordViewController alloc]init];
        [self.navigationController pushViewController:ForgotPasswordVC animated:YES];
#else
        ForgotPasswordViewController *ForgotPasswordVC =[[ForgotPasswordViewController alloc]init];
        [ForgotPasswordVC setCustomerTitle:@"修改登录密码"];
        [self.navigationController pushViewController:ForgotPasswordVC animated:YES];
#endif
        
    }
    if (indexPath.row == 2) {
        
        
#if BusinessTag
        BusinessReplacePhoneVC *ReplacePhoneVC = [[BusinessReplacePhoneVC alloc]init:BusinessReplacePhoneType_Code];
        ReplacePhoneVC.myModel = _myBusinessModel;
        [self.navigationController pushViewController:ReplacePhoneVC animated:YES];
#else
        ReplacePhoneViewController *ReplacePhoneVC =[[ReplacePhoneViewController alloc]init:ReplacePhoneType_Code];
        [self.navigationController pushViewController:ReplacePhoneVC animated:YES];
#endif
 
    }
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
