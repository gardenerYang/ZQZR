//
//  HomeListViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HomeListViewController.h"
#import "HeadswitchBtnView.h"
#import "InvestmentViewController.h"
@interface HomeListViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) InvestmentViewController *LiveStoryView;
@property (nonatomic, strong) InvestmentViewController *LiveShareView;

@end

@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithScrollView];
    [self addHeadBtn];
}
-(void)addHeadBtn{
    __weak typeof(self) wf = self;
    
    HeadswitchBtnView *switchBtnView =[[HeadswitchBtnView alloc]initWithType];
    switchBtnView.leftTitle = @"资产专区";
    switchBtnView.rightTitle = @"票据直投";
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
    }
    return _scrollView;
}
-(InvestmentViewController *)LiveStoryView{
    if (!_LiveStoryView) {
        _LiveStoryView = [[InvestmentViewController alloc]initType:_type1];
        _LiveStoryView.isShowTicket = YES;
    }
    return _LiveStoryView;
}
-(InvestmentViewController *)LiveShareView{
    if (!_LiveShareView) {
        _LiveShareView = [[InvestmentViewController alloc]initType:_type2];
        _LiveShareView.isShowTicket = YES;

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
