//
//  FindHomeVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "FindHomeVC.h"
#import "HomeButtonTableViewCell.h"
#import "TipsViewController.h"
#import "HomeListViewController.h"
#import "ProductCommendCell.h"
#import "ProductModuleCell.h"
#import "MSCycleScrollView.h"
#import "MSExampleDotView.h"
#import "HttpRequest+Active.h"
#import "HttpRequest+Home.h"
#import "ActivityListCell.h"
@interface FindHomeVC ()<MSCycleScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSArray * bannerArray;
@property (nonatomic, strong) MSCycleScrollView          *carouselView;


@end

@implementation FindHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self setCustomerTitle:@"发现"];
    [self requestBannerData];
    [self requestList];
    [self createUI];
}
- (void)createUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ActivityListCell"];
    [self.tableView registerClass:[HomeButtonTableViewCell class] forCellReuseIdentifier:@"HomeButtonTableViewCell"];
    
    MSCycleScrollView *cycleScrollView = [MSCycleScrollView cycleViewWithFrame:CGRectMake(0, 0, kWidth, 150) delegate:self placeholderImage:kBannerPlaceholderImage];
    cycleScrollView.pageControlStyle = kMSPageContolStyleCustomer;
    cycleScrollView.pageControlAliment = kMSPageContolAlimentRight;
    cycleScrollView.imageUrls = self.bannerArray;
    cycleScrollView.dotViewClass = [MSExampleDotView class];
    cycleScrollView.pageControlDotSize = CGSizeMake(6, 6);
    cycleScrollView.spacingBetweenDots = 10;
    self.tableView.tableHeaderView = cycleScrollView;
}
-(void)requestList{
    __weak typeof(self) wf = self;
    [HttpRequest getActiveDataRequestsuccess:^(NSArray * _Nonnull dataArr, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        [self.dataArray addObjectsFromArray:dataArr];
        [wf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [wf.tableView stopReload];
        [MBProgressHUD showErrorMessage:error.localizedDescription];
        
    }];
}
-(void)requestBannerData{
    __weak typeof(self) wf = self;
    [HttpRequest achieveImgWithState:@"2" Requestsuccess:^(NSArray * _Nonnull imgArr) {
        [MBProgressHUD hideHUD];
        wf.bannerArray = imgArr;
        NSArray *urlArr =  [imgArr valueForKeyPath:@"imageUrl"];
        wf.carouselView = [MSCycleScrollView cycleViewWithFrame:CGRectMake(0, 0, Iphonewidth, 150) delegate:self placeholderImage:kBannerPlaceholderImage];
        wf.carouselView.pageControlStyle = kMSPageContolStyleCustomer;
        wf.carouselView.pageControlAliment = kMSPageContolAlimentCenter;
        wf.carouselView.imageUrls = urlArr;
        wf.carouselView.dotViewClass = [MSExampleDotView class];
        wf.carouselView.pageControlDotSize = CGSizeMake(5, 5);
        wf.carouselView.spacingBetweenDots = 10;
        self.tableView.tableHeaderView = wf.carouselView;
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 2;
    }else{
        return self.dataArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            return ((kWidth-45)/2)*220/330+15;
        }
        return 42;
    }else{
        return (kWidth-30)*173/345;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            ProductModuleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductModuleCell"];
            if (cell ==nil) {
                cell = [[ProductModuleCell alloc]initWithReuseIdentifier:@"ProductModuleCell" imageArray:@[@"news_company",@"news_industry"]];
                cell.backgroundColor = kTabBGColor;
            }
            return cell;
        }else{
            ProductCommendCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCommendCell"];
            if (cell ==nil) {
                cell = [[ProductCommendCell alloc]initWithReuseIdentifier:@"ProductCommendCell" imageString:@"activity_recommend"];
                cell.backgroundColor = [UIColor whiteColor];
            }
            return cell;
        }
    }else{
        ActivityListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityListCell"];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
}


@end

