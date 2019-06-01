//
//  SetUpViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "SetUpViewController.h"
#import "MyTableViewCell.h"
#import "SuggestionsViewController.h"
#import "TipsViewController.h"
#import "SecuritySettingVC.h"
#import "HttpRequest+my.h"
#import "AppUserProfile.h"
#import "HelpCenterVC.h"
@interface SetUpViewController ()
@property(nonatomic,strong)  NSArray *titleArr;

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor m_bgColor];
    [self setCustomerTitle:@"设置"] ;
    
    _titleArr = [NSArray arrayWithObjects:@"安全设置",@"帮助中心",@"意见反馈",@"关于我们",@"联系客服", nil];

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
            [[AppUserProfile sharedInstance]cleanUp];
            [MBProgressHUD showSuccessMessage:@"退出登录成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:ZHMainType object:nil];
            [HttpRequest exitLogonRequestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
                [MBProgressHUD hideHUD];
                
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD showErrorMessage:error.localizedDescription];
            }];
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
            SecuritySettingVC *SecurityVC = [[SecuritySettingVC alloc]init];
            [self.navigationController pushViewController:SecurityVC animated:YES];
        }
            break;
        case 1:{
            HelpCenterVC * vc = [[HelpCenterVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            SuggestionsViewController *SuggestionsVC = [[SuggestionsViewController alloc]init];
            [self.navigationController pushViewController:SuggestionsVC animated:YES];
        }
            break;
        case 4:{
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
