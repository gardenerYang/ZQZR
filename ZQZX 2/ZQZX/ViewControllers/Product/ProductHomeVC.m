//
//  ProductHomeVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "ProductHomeVC.h"
#import "HomeButtonTableViewCell.h"
#import "TipsViewController.h"
#import "HomeListViewController.h"
#import "ProductCommendCell.h"
#import "ProductModuleCell.h"
#import "ProductListCell.h"
@interface ProductHomeVC ()
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ProductHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"资产配置服务"];
    [self createUI];
}
- (void)createUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ProductListCell"];
    [self.tableView registerClass:[HomeButtonTableViewCell class] forCellReuseIdentifier:@"HomeButtonTableViewCell"];
}
- (void)requestData{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 3;
    }else{
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            return 103;
        }else if (indexPath.row ==1){
            return 42;
        }else{
            return ((kWidth-45)/2)*220/330+15;
        }
    }else{
        return (kWidth-30)*173/345;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            NSArray *titleArr = [NSArray arrayWithObjects:@"票据产品",@"保险产品",@"银行产品", nil];
            NSArray *selectArr = [NSArray arrayWithObjects:@"home_negotiable",@"home_insure",@"home_bank", nil];
            NSArray *noselectArr = [NSArray arrayWithObjects:@"home_negotiable",@"home_insure",@"home_bank", nil];
            HomeButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeButtonTableViewCell class]) forIndexPath:indexPath];
            cell.backgroundColor=[UIColor m_bgColor];
            __weak typeof(self) wf = self;
            [cell setBtnTitle:titleArr selectImgArr:selectArr imgArr:noselectArr color:kTitleColor];
            [cell setBtnClickBlock:^(NSUInteger selectClick) {
                if (![AppUserProfile sharedInstance].isLogon) {
                    [self toLoginVC];
                    return ;
                }
                NSString *title;
                if (selectClick == 0) {
                    title = @"票据产品";
                }else if (selectClick == 1){
                    title = @"保险产品";
                }else if (selectClick == 2){
                    title = @"银行产品";
                }
                if (selectClick == 1) {
                    TipsViewController *TipsVC=[[TipsViewController alloc]init];
                    TipsVC.titleLbText = @"温馨提示";
                    TipsVC.srcLbText = @"此功能暂未开放,敬请期待";
                    [TipsVC setTapCancelBtnblock:^{
                        
                    }];
                    [TipsVC setTapConfirmBtnblock:^{
                        [wf.navigationController popToRootViewControllerAnimated:YES];
                    }];
                    [TipsVC showInVC: wf ];
                    return ;
                }else if (selectClick == 2){
                    WebviewViewController * vc = [[WebviewViewController alloc]init];
                    vc.url = @"https://rich.qyrich.com/index?channelNo=zqzr&organ=02200001";
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (selectClick == 0) {
                    HomeListViewController *homeListVC = [[HomeListViewController alloc]init];
                    [homeListVC setCustomerTitle:title];
                    homeListVC.type1 = @"0";
                    homeListVC.type2 = @"4";
                    [wf.navigationController pushViewController:homeListVC animated:YES];
                }
                
            }];
            return cell;
        }else if (indexPath.row ==1){
            ProductCommendCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCommendCell"];
            if (cell ==nil) {
                cell = [[ProductCommendCell alloc]initWithReuseIdentifier:@"ProductCommendCell" imageString:@"product_recommend"];
            }
            return cell;
        }else{
            ProductModuleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductModuleCell"];
            if (cell ==nil) {
                cell = [[ProductModuleCell alloc]initWithReuseIdentifier:@"ProductModuleCell" imageArray:@[@"product_property",@"product_piaoju"]];
            }
            return cell;
        }
    }else{
        ProductListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductListCell"];
        return cell;
    }
}


@end
