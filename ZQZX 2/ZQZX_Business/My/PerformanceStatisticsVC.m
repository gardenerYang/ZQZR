//
//  PerformanceStatisticsVC.m
//  ZQZX
//
//  Created by 中企 on 2018/10/22.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "PerformanceStatisticsVC.h"
#import "HeadswitchBtnView.h"
#import "PlanViewController.h"
#import "MonthlyStatisticsViewController.h"
#import "AllStatisticsViewController.h"

@interface PerformanceStatisticsVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) MonthlyStatisticsViewController *LiveStoryView;
@property (nonatomic, strong) AllStatisticsViewController *LiveShareView;


@end

@implementation PerformanceStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor m_gray];
    [self setCustomerTitle:@"业绩统计"];
    [self initWithScrollView];
    [self addHeadBtn];
}//    self.scrollView.contentOffset = CGPointMake(Iphonewidth*(index-1), 0);

-(void)addHeadBtn{
    __weak typeof(self) wf = self;
    
    HeadswitchBtnView *switchBtnView =[[HeadswitchBtnView alloc]initWithType];
    switchBtnView.leftTitle = @"本月";
    switchBtnView.rightTitle = @"全部";
    [self.view addSubview:switchBtnView];
    [switchBtnView setTapLeftBtnblock:^{
        wf.scrollView.contentOffset = CGPointMake(0, 0);
    }];
    [switchBtnView setTapRightBtnblock:^{
        wf.scrollView.contentOffset = CGPointMake(Iphonewidth, 0);
        
    }];
    [switchBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, IphoneHight-NavHeight-StatusBarHight)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator  = NO;
        _scrollView.showsVerticalScrollIndicator    = NO;
        _scrollView.contentSize     = CGSizeMake(Iphonewidth * 2, IphoneHight-NavHeight-StatusBarHight);
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = NO;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}
-(MonthlyStatisticsViewController *)LiveStoryView{
    if (!_LiveStoryView) {
        _LiveStoryView = [[MonthlyStatisticsViewController alloc]init];
    }
    return _LiveStoryView;
}
-(AllStatisticsViewController *)LiveShareView{
    if (!_LiveShareView) {
        _LiveShareView = [[AllStatisticsViewController alloc]init];
    }
    return _LiveShareView;
}
-(void)initWithScrollView{
    [self.view addSubview:self.scrollView];
    [self addChildViewController:self.LiveStoryView];
    [self addChildViewController:self.LiveShareView];
    
    self.LiveStoryView.view.frame = CGRectMake(0, 0, Iphonewidth, IphoneHight-NavHeight-StatusBarHight);
    self.LiveShareView.view.frame = CGRectMake(Iphonewidth, 0, Iphonewidth, IphoneHight-NavHeight-StatusBarHight);
    [self.scrollView addSubview:self.LiveStoryView.view];
    [self.scrollView addSubview:self.LiveShareView.view];
}

#pragma mark - UIScrollDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
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
