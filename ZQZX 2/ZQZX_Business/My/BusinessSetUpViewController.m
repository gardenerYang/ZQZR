//
//  BusinessSetUpViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/11/3.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BusinessSetUpViewController.h"
#import "MyTableViewCell.h"
#import "SuggestionsViewController.h"
#import "TipsViewController.h"
#import "SecuritySettingVC.h"
#import "HttpRequest+my.h"
#import "AppUserProfile.h"
#import "PerfectinformationViewController.h"
#import "BusinessCertificationVC.h"
#import "HelpCenterVC.h"
@interface BusinessSetUpViewController ()
@property(nonatomic,strong)  NSArray *titleArr;

@end

@implementation BusinessSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor m_bgColor];
    [self setCustomerTitle:@"设置"] ;
    _titleArr = [NSArray arrayWithObjects:@"实名认证",@"完善信息",@"安全设置",@"帮助中心",@"分享邀请",@"关于我们",@"联系客服", nil];
    
    [self addUI];
    [self setupFootVie];
}
-(void)addUI{
    
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self setupFootVie];
}
-(void)setupFootVie{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, 200)];
    footview.userInteractionEnabled = YES;
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitBtn setBackgroundColor:kMainColor];
    [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    quitBtn.layer.masksToBounds = YES;
    quitBtn.layer.cornerRadius = 30;
    __weak typeof(self) wf = self;
    [quitBtn addAction:^(UIButton *sender) {
        
        TipsViewController *TipsVC=[[TipsViewController alloc]init];
        TipsVC.titleLbText = @"温馨提示";
        TipsVC.srcLbText = @"你确定要退出登录吗?";
        [TipsVC setTapCancelBtnblock:^{
            
        }];
        [TipsVC setTapConfirmBtnblock:^{
//            [MBProgressHUD showActivityMessageInView:@"退出登录中..."];
//
//            [HttpRequest exitLogonRequestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
//                [MBProgressHUD hideHUD];
                [[AppUserProfile sharedInstance]cleanUp];
                [MBProgressHUD showSuccessMessage:@"退出登录成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:ZHMainType object:nil];
                
//            } failure:^(NSError * _Nonnull error) {
//                [MBProgressHUD showErrorMessage:error.localizedDescription];
//            }];
        }];
        [TipsVC showInVC: self ];
        
    }];
    [footview addSubview:quitBtn];
    [quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(-40);
    }];
    self.tableView.tableFooterView=footview;
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
    if (indexPath.row == 0) {
        
    
    if (_myModel.idNo.length == 0 || _myModel.realName.length == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.srcLb.text = @"未认证";
    }else{
       cell.srcLb.text = @"已认证";
        
    }
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }

    if (indexPath.row == _titleArr.count-1 ) {
        cell.srcLb.text = @"400-7666-168";
    }
    return cell;
    
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:{
            if (_myModel.idNo.length == 0 || _myModel.realName.length == 0) {
                BusinessCertificationVC *vc = [[BusinessCertificationVC alloc]init];
                vc.myModel = _myModel;
                [self.navigationController pushViewController:vc animated:YES];
            }

        }
            break;
        case 1:{
            PerfectinformationViewController *perfectinformationVC = [[PerfectinformationViewController alloc]init];
            [self.navigationController pushViewController:perfectinformationVC animated:YES];
            
        }
            break;
        case 2:{
        SecuritySettingVC *SecurityVC = [[SecuritySettingVC alloc]init];
        #if BusinessTag
        SecurityVC.myBusinessModel = _myModel;

        #else

        #endif
        [self.navigationController pushViewController:SecurityVC animated:YES];

        }
            break;
        case 3:{
            HelpCenterVC * vc = [[HelpCenterVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        case 6:{
            TipsViewController *TipsVC=[[TipsViewController alloc]init];
            TipsVC.titleLbText = @"温馨提示";
            TipsVC.srcLbText = @"拨打理财通电话";
            [TipsVC setTapCancelBtnblock:^{
                
            }];
            [TipsVC setTapConfirmBtnblock:^{
             [self tel:@"400-7666-168"];
            }];
            [TipsVC showInVC: self ];
        }
            break;
            
        default:
            break;
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
