//
//  ProductListHomeVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/2.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "ProductListHomeVC.h"
#import "SGPagingView.h"
#import "ProductListAssetVC.h"
#import "ProductListNegotiableVC.h"
#import "ProductHomeVC.h"
@interface ProductListHomeVC ()<SGPageTitleViewDelegate, SGPageContentViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@end

@implementation ProductListHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"票据产品"];
    [self initPageView];
    
}
- (void)initPageView{
    self.view.backgroundColor = kTabBGColor;
    ProductListAssetVC *oneVC = [[ProductListAssetVC alloc] init];
    ProductListNegotiableVC *twoVC = [[ProductListNegotiableVC alloc] init];
    
    NSArray *childArr = @[oneVC, twoVC];
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 60, kWidth, kHeight-kNaviBarHeight-60) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"资产专区", @"票据直投"];
//    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
//    configure.titleFont = kFont(14);
//    configure.titleColor = kLightGray;
//    configure.titleSelectedColor = kMainColor;
//    configure.titleGradientEffect = YES;
//    configure.indicatorColor = kMainColor;
//    configure.showBottomSeparator = NO;
//    self.pageTitleView= [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 10, kWidth, 35) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 10, kWidth, 35) delegate:self titleNames:titleArr titleFont:[UIFont systemFontOfSize:14]];
    _pageTitleView.isTitleGradientEffect = YES;
    _pageTitleView.titleColorStateNormal = kLightGray;
    _pageTitleView.titleColorStateSelected = kMainColor;
    _pageTitleView.indicatorColor = kMainColor;
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthStyleEqual;
    _pageTitleView.isShowBottomSeparator = NO;
    _pageTitleView.isNeedBounces = NO;
    _pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
}
#pragma mark ---- pagedelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


@end

