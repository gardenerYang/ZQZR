//
//  MyBusinessViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/22.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessViewController.h"
#import "MyBusinessCell.h"
#import "StretchingFlowLayout.h"
#import "BusinessHeaderView.h"
#import "PerformanceStatisticsVC.h"
#import "InvestmentManagementVC.h"
#import "MyUserViewController.h"
#import "MyBusinessOrderdetailsVC.h"//我的订单详情
#import "MyBusinessModel.h"
#import "HttpRequest+MyBusiness.h"
#import "MyBusinessOrderViewController.h"
#import "MyBusinessOtherOrderVC.h"//分类订单
#import "MyBusinessmessageViewController.h"
#import "BusinessSetUpViewController.h"
@interface MyBusinessViewController ()
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)NSMutableArray *imgArr;
@property(nonatomic,strong)MyBusinessModel *myModel;

@end

@implementation MyBusinessViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:  @"red_nav_x"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if ([AppUserProfile sharedInstance].isLogon) {
        [self getBusinessNews];//获取信息        
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
}
-(void)getBusinessNews{
    [HttpRequest getFinancialPlannerInfoRequestsuccess:^(MyBusinessModel * _Nonnull model, NSString * _Nonnull message) {
        self.myModel = model;
        [self.collectionView reloadData];
    } failure:^(NSError * _Nonnull error) {
        if ([error.localizedDescription isEqualToString:@"操作失败"]) {
            
        }
        else
        {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) wf = self;

    [self setRightBarButtonItemWithImg:@"setUp_write" selector:^(id sender) {
        BusinessSetUpViewController *setupVc =[[BusinessSetUpViewController alloc]init];
        setupVc.myModel = wf.myModel;
        [wf.navigationController pushViewController:setupVc animated:YES];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginback:)
                                                 name:Loginback
                                               object:nil];
    [self.collectionView registerHeader:[BusinessHeaderView class]];
    [self.collectionView registerClass:[MyBusinessCell class]];
    self.titleArr = [@[@"待受理订单",@"我的订单",@"待签约订单",@"退回订单",@"用户投资管理",@"我的用户",@"业绩统计",@"我的信息"] mutableCopy];
    
    _imgArr = [@[@"mybusiness_0",@"mybusiness_1",@"mybusiness_2",@"mybusiness_3",@"mybusiness_4",@"mybusiness_5",@"mybusiness_6",@"mybusiness_7"] mutableCopy];

}
- (void)loginback:(NSNotification *)notification
{
    self.tabBarController.selectedIndex = 0;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _titleArr.count;
}
- (UICollectionViewLayout *)collectionViewLayout {
    UICollectionViewFlowLayout *layout = [[StretchingFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(Iphonewidth/2, 100);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;

    layout.headerReferenceSize = CGSizeMake(Iphonewidth, Iphonewidth *0.52);
//    layout.sectionInset = UIEdgeInsetsMake(0, 10, 30, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    return layout;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyBusinessCell *cell = [collectionView dequeueReusableClass:[MyBusinessCell class] forIndexPath:indexPath];
    cell.titleLB.text = _titleArr[indexPath.row];
    cell.headimgView.image = [UIImage imageNamed:_imgArr[indexPath.row]];
//    NSLog(@"%@",_imgArr[indexPath.row]);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
         BusinessHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BusinessHeaderView class]) forIndexPath:indexPath];
        header.header.titleLabel.text = [self phone:self.myModel.phone] ;
        [header.header.photoImgView sd_setImageWithString:self.myModel.headImageUrl];
        return header;
    }
    return nil;
}

#pragma mark delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
        case 0:{
            MyBusinessOtherOrderVC *OtherVC =[[MyBusinessOtherOrderVC alloc]init];
            OtherVC.status =@"0";
            [OtherVC setCustomerTitle:@"待受理订单"];
            [self.navigationController pushViewController:OtherVC animated:YES];
        }
        break;
        case 1:{
//            MyBusinessOrderdetailsVC *orderdetailsVC =[[MyBusinessOrderdetailsVC alloc]init];
//            [self.navigationController pushViewController:orderdetailsVC animated:YES];
            MyBusinessOrderViewController *OrderVC =[[MyBusinessOrderViewController alloc]init];
        
            [self.navigationController pushViewController:OrderVC animated:YES];
          
            
        }
            break;
        case 2:{
            MyBusinessOtherOrderVC *OtherVC =[[MyBusinessOtherOrderVC alloc]init];
            OtherVC.status =@"1";
            [OtherVC setCustomerTitle:@"待签约订单"];
            [self.navigationController pushViewController:OtherVC animated:YES];
        }
            break;
        case 3:{
            MyBusinessOtherOrderVC *OtherVC =[[MyBusinessOtherOrderVC alloc]init];
            OtherVC.status =@"4";
            [OtherVC setCustomerTitle:@"退回订单"];
            [self.navigationController pushViewController:OtherVC animated:YES];
        }
            break;
        case 4:{//用户投资管理
            InvestmentManagementVC *investmentManagementVC =[[InvestmentManagementVC alloc]init];
            [self.navigationController pushViewController:investmentManagementVC animated:YES];
        }
            break;
        case 5:{//我的用户
            MyUserViewController *myUserVC =[[MyUserViewController alloc]init];
            [self.navigationController pushViewController:myUserVC animated:YES];
        }
            break;
        case 6:{
            PerformanceStatisticsVC *statisticsVC =[[PerformanceStatisticsVC alloc]init];
            [self.navigationController pushViewController:statisticsVC animated:YES];
        }
            break;
        case 7:{
            MyBusinessmessageViewController *MyVC =[[MyBusinessmessageViewController alloc]init];
            MyVC.myModel = self.myModel;
            [self.navigationController pushViewController:MyVC animated:YES];
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
