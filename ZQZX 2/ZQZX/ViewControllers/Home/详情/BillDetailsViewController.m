//
//  BillDetailsViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/16.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BillDetailsViewController.h"
#import "DetailsBottomView.h"
#import "DetailsHeadView.h"
#import "DetailsTableViewCell.h"
#import "SuccessViewController.h"
#import "ProjectIntroductionVC.h"
#import "ExamineViewController.h"
#import "RecordListViewController.h"
#import "TicketInformationVC.h"
static CGFloat const kWMMenuViewHeight = 44.0;
//static CGFloat const kWMHeaderViewHeight = IphoneHight - 60;
//static CGFloat const kNavigationBarHeight = 64;
@interface BillDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *musicCategories;
@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, assign) CGFloat                   kWMHeaderViewHeight;
@property (nonatomic, assign) CGFloat                   kNavigationBarHeight;

@end

@implementation BillDetailsViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:  @"red_nav_x"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
}
- (instancetype)init {
    if (self = [super init]) {
        _kWMHeaderViewHeight = IphoneHight - 60;
        _kNavigationBarHeight = 64 + StatusBarHight;
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
        self.titleColorSelected = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        self.titleColorNormal = [UIColor colorWithRed:0.4 green:0.8 blue:0.1 alpha:1.0];
        
        self.menuViewHeight = kWMMenuViewHeight;
        self.maximumHeaderViewHeight = _kWMHeaderViewHeight;
        self.minimumHeaderViewHeight = _kNavigationBarHeight;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf = self;

    
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, IphoneHight - _kNavigationBarHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight= 80.f;
    self.tableView.delegate= self;
    self.tableView.dataSource= self;
    [self.view addSubview: self.tableView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
//    DetailsBottomView *bottomView = [[DetailsBottomView alloc]initWithType];
//    [bottomView setAppointmentBlock:^{
//        SuccessViewController *successVC=[[SuccessViewController alloc]init];
//        successVC.titleLbText = @"预约成功";
//        successVC.srcLbText = @"即将跳转到产品列表页";
//        [successVC showInVC:weakSelf];
//    }];
//    [self.view addSubview:bottomView];
//    bottomView.frame = CGRectMake(0, IphoneHight-60, Iphonewidth, 60);
//    [bottomView bringSubviewToFront:self.view];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view.mas_bottom).offset(-60);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(60);
//    }];
    [self addHeaderView];
}
-(void)addHeaderView{
    DetailsHeadView *detailsHeadView = [[DetailsHeadView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, Iphonewidth *0.52 + 80)];
    [self.view addSubview:detailsHeadView];
    self.tableView.tableHeaderView = detailsHeadView;
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat headerViewHeight = _kWMHeaderViewHeight;
    CGFloat headerViewX = 0;
    UIScrollView *scrollView = (UIScrollView *)self.view;
    if (scrollView.contentOffset.y < 0) {
        headerViewX = scrollView.contentOffset.y;
        headerViewHeight -= headerViewX;
    }
    self.tableView.frame = CGRectMake(0, headerViewX, CGRectGetWidth(self.view.bounds), headerViewHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)btnClicked:(id)sender {
    NSLog(@"touch up inside");
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    if (scrollView.contentOffset.y < 0) {
        [self.view setNeedsLayout];
    }
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return [ProjectIntroductionVC new];
        case 1:{
            return [ExamineViewController new];
        }
        case 2:{
            return [TicketInformationVC new];
        }
        default:
            return [RecordListViewController new];
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

#pragma mark - lazy
- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"项目介绍", @"项目审核",@"资质信息",@"预约记录"];
    }
    return _musicCategories;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text= [NSString stringWithFormat:@"测试数据————%ld", indexPath.row];
        cell.textLabel.textColor= kMainColor;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    return cell;
}

/*- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addUI];
//    [self addHeaderView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:  @"red_nav_x"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    


}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
  
}*/
/*-(void)addUI{
    __weak typeof(self) weakSelf = self;

    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    //    [self initSuspension];
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[DetailsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DetailsTableViewCell class])];
   
    [self setLeftBarButtonItemWithImg:@"back_write" selector:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self setCustomerTitle:@"详情" color:[UIColor whiteColor]];
    
    
    //    [self.tableView addMJ_Header:^{
    ////        [weakSelf requestHome];
    //    }];
    //    [self.tableView refresh];
    DetailsBottomView *bottomView = [[DetailsBottomView alloc]initWithType];
    [bottomView setAppointmentBlock:^{
        SuccessViewController *successVC=[[SuccessViewController alloc]init];
        successVC.titleLbText = @"预约成功";
        successVC.srcLbText = @"即将跳转到产品列表页";
        [successVC showInVC:weakSelf];
    }];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom).offset(-60);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
}
-(void)addHeaderView{
    DetailsHeadView *detailsHeadView = [[DetailsHeadView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, Iphonewidth *0.52 + 80)];
    [self.view addSubview:detailsHeadView];
    self.tableView.tableHeaderView = detailsHeadView;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailsTableViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor=[UIColor m_bgColor];
    cell.titleLb1.text = @"一次性还本付息";
    cell.titleLb2.text = @"一万及整数倍数递增";

    return cell;
  
}


//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
