//
//  HomeViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "SuccessViewController.h"
#import "HomeTableViewCell.h"
#import "HomeFineTableViewCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "HomeButtonTableViewCell.h"
#import "InvestmentViewController.h"
#import "HttpRequest+Home.h"
#import "HomeModel.h"
#import "NSString+Validation.h"
#import "HomeListViewController.h"
#import "TipsViewController.h"
#import "BillDetailsViewController.h"
#import "InvestmentdetailsVC.h"
#import "AppUserProfile.h"
#import "HomeUpdateVC.h"
#import "ZJJTimeCountDown.h"
#import "HomeNotificationView.h"
#import "RemindListVC.h"
#import "RemindListSelectView.h"
#import "ActivityWebViewVC.h"
#import "HomeCorporateNewsCell.h"
#import "HomeIndustryNewsItemCell.h"
#import "HomeVersionCell.h"
@interface HomeViewController ()<SDCycleScrollViewDelegate,ZJJTimeCountDownDelegate>
@property (nonatomic, strong) SDCycleScrollView          *carouselView;
@property (nonatomic, strong) HomeModel          *homeModel;
@property (nonatomic, strong) NSArray          *imgArr;
@property(nonatomic,strong) ZJJTimeCountDown * countDown;
@property(nonatomic,strong)NSMutableArray *timeListArr;
@property (nonatomic,strong)HomeNotificationView * remindView;
@property(nonatomic,strong)NSMutableArray *remindtArr;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self ZHNavigationBarHidden:YES];
#if BusinessTag
    
#else
    if (![AppUserProfile sharedInstance].isLogon) {
        [self toLoginVC];
    }else{
        static dispatch_once_t disOnce;
        dispatch_once(&disOnce,^ {
            [self getUpdateVersion];
        });
    }
    
#endif
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self ZHNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeListArr = [NSMutableArray array];
    [self initUI];
    _imgArr = [[NSArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginDidSuccess) name:@"loginDidSuccess" object:nil];
    [self getHomeRemindUserOrFinancialPlannersuccess];
}
- (void)getUpdateVersion{
    [HttpRequest getUpdateRequestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
        NSLog(@"%@",data.data);
        NSDictionary * dic = data.data;
//        content = nothing;content更新内容
//        isCompulsion = 0;isCompulsion是否强制更新（1为强制，0不强制）
//        versionCode = "1.0.0";
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSInteger isUpdate = [NSString compareVersion:dic[@"versionCode"] to:app_Version];
            if (isUpdate == 1) {
                [HomeUpdateVC showUpdateAlertWithVersion:dic[@"versionCode"] Description:dic[@"content"] isCompulsion:[dic[@"isCompulsion"] boolValue] clikRightBtn:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"loadUrl"]]];
                }];
            }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)loginDidSuccess{
}
-(void)getHomeData{
    __weak typeof(self) wf = self;

    [HttpRequest getTopOrSuggInvestionsRequestsuccess:^(HomeModel * _Nonnull homeModel, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        self.homeModel = homeModel;
        for (InveItem * item in self.homeModel.inve) {
            timeModel * model = [[timeModel alloc]init];
            if (item.status==1) {
                model.startTime = [self getNowTimeTimestamp];
                model.endTime = [self getEndTimeTimestampWithremainingCollectionTime:item.remainingCollectionTime];
            }else{
                model.startTime = @"0";
                model.endTime = @"0";
            }
            [self.timeListArr addObject:model];
        }
        [wf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
        [wf.tableView stopReload];
    }];
}
//获取时候有续投l项目

- (void)getHomeRemindUserOrFinancialPlannersuccess{
    [HttpRequest homeRemindUserOrFinancialPlannersuccess:^(NSArray * _Nonnull listArr) {
        self.remindtArr = [listArr copy];
        if (self.remindtArr.count > 0) {
            for (InveItem * model in self.remindtArr) {
                model.operation = 1;
            }
            [self.remindView show];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];

    }];
}
-(void)getImgData{
    __weak typeof(self) wf = self;
    [HttpRequest achieveImgRequestsuccess:^(NSArray * _Nonnull imgArr) {
          [MBProgressHUD hideHUD];
        wf.imgArr = imgArr;
        NSLog(@"%@",[imgArr valueForKeyPath:@"imageUrl"]);
        NSArray *urlArr =  [imgArr valueForKeyPath:@"imageUrl"];
        wf.carouselView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Iphonewidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"Wload"]];
        wf.carouselView.currentPageDotImage = [UIImage imageNamed:@"remind_btn"];
        wf.carouselView.pageDotImage = [UIImage imageNamed:@"home_banner_select"];
        wf.carouselView.imageURLStringsGroup = urlArr;
        self.tableView.tableHeaderView = wf.carouselView;
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}

- (void)initUI {
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    //    [self initSuspension];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerClass:[HomeButtonTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeButtonTableViewCell class])];
    [self.tableView registerClass:[HomeVersionCell class] forCellReuseIdentifier:NSStringFromClass([HomeVersionCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCorporateNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeCorporateNewsCell"];
    __weak typeof(self) wf = self;

    [self.tableView addMJ_Header:^{
        [wf getImgData];//获取图片数据
        [wf getHomeData];//获取首页数据
        
    }];
    [self.tableView refresh];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return 103;
    }else if (indexPath.row ==1){
        return 88+((kWidth-60)*240/630);
    }else if (indexPath.row ==2){
        return 65 + (((kWidth-60)/3)*185/120);
    }else{
        return (kWidth-30)*200/690+15;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSArray *titleArr = [NSArray arrayWithObjects:@"票据产品",@"保险产品",@"银行产品",@"其他产品", nil];
        NSArray *selectArr = [NSArray arrayWithObjects:@"home_negotiable",@"home_insure",@"home_bank",@"home_other", nil];
        NSArray *noselectArr = [NSArray arrayWithObjects:@"home_negotiable",@"home_insure",@"home_bank",@"home_other", nil];
        
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
                title = @"票据";
            }else if (selectClick == 1){
                title = @"保理";
                
            }else if (selectClick == 2){
                title = @"房产";
            }else{
                title = @"股权";
            }
            if (selectClick == 2) {
         
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
            }else if (selectClick == 3){
                WebviewViewController * vc = [[WebviewViewController alloc]init];
                vc.url = @"https://rich.qyrich.com/index?channelNo=zqzr&organ=02200001";
                [self.navigationController pushViewController:vc animated:YES];
            }else if (selectClick == 0) {
                HomeListViewController *homeListVC = [[HomeListViewController alloc]init];
                [homeListVC setCustomerTitle:title];
                homeListVC.type1 = @"0";
                homeListVC.type2 = @"4";
                [wf.navigationController pushViewController:homeListVC animated:YES];
            }else{
                InvestmentViewController *investmentVC =[[InvestmentViewController alloc]initType:@"1"];
                investmentVC.type = 1;
                [investmentVC setCustomerTitle:title];
                [self.navigationController pushViewController:investmentVC animated:YES];
            }
           
        }];
        return cell;
    }else if (indexPath.row == 1) {
        HomeCorporateNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCorporateNewsCell"];
        return cell;
    }else if (indexPath.row ==2){
        HomeIndustryNewsItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeIndustryNewsItemCell"];
        if (cell ==nil) {
            cell = [[HomeIndustryNewsItemCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"HomeIndustryNewsItemCell"];
        }
        return cell;
    }else{
        HomeVersionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeVersionCell"];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (![AppUserProfile sharedInstance].isLogon) {
            [self toLoginVC];
            return ;
        }
        InveItem *model  = self.homeModel.inve[indexPath.row];
        InvestmentdetailsVC *investmentdetailsVC = [[InvestmentdetailsVC alloc]init];
        investmentdetailsVC.productID = @(model.id).stringValue;
        investmentdetailsVC.status = model.status;
        [investmentdetailsVC setCustomerTitle:model.name];
        investmentdetailsVC.type = model.type;
        [self.navigationController pushViewController:investmentdetailsVC animated:YES];
    }
    if (indexPath.section == 2) {
        MomentsItem *model  = self.homeModel.moments[indexPath.row];
        [self gotoWebURL:model.urlHref htmlText:model.content title:@""];
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    ImgModel *model = _imgArr[index];
    if (model.redirectUrl.length>0) {
        [self gotoWebURL:model.redirectUrl htmlText:model.content title:@""];
    }
    
}
- (ZJJTimeCountDown *)countDown{
    
    if (!_countDown) {
        _countDown = [[ZJJTimeCountDown alloc] initWithScrollView:self.tableView dataList:self.timeListArr];
        _countDown.delegate = self;
        _countDown.timeStyle = ZJJCountDownTimeStyleTamp;
        
    }
    return _countDown;
}
- (HomeNotificationView *)remindView{
    if (_remindView == nil) {
        _remindView = [[[NSBundle mainBundle]loadNibNamed:@"HomeNotificationView" owner:self options:0]lastObject];
        [kWindow addSubview:_remindView];
        [_remindView setFrame:kWindow.bounds];
        [_remindView show];
        __weak typeof(self) wf = self;

        [_remindView.doneBtn addTapGestureBlock:^(UIView *view) {
            [wf.remindView hide];
            RemindListVC * vc = [[RemindListVC alloc]init];
            vc.listArray = self.remindtArr;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _remindView;
}
- (NSAttributedString *)customTextWithTimeLabel:(ZJJTimeCountDownLabel *)timeLabel timeCountDown:(ZJJTimeCountDown *)timeCountDown{
    
    NSArray *textArray = @[[NSString stringWithFormat:@"%.2ld",timeLabel.days],
                           @"天",
                           [NSString stringWithFormat:@"%.2ld",timeLabel.hours],
                           @"小时",
                           [NSString stringWithFormat:@"%.2ld",timeLabel.minutes],
                           @"分",
                           [NSString stringWithFormat:@"%.2ld",timeLabel.seconds],
                           @"秒"];
    
    return [self dateAttributeWithTexts:textArray];
}
- (NSAttributedString *)dateAttributeWithTexts:(NSArray *)texts{
    NSDictionary *datedic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:10],NSForegroundColorAttributeName:[UIColor withHexStr:@"469ee8"]};
    NSMutableAttributedString *dateAtt = [[NSMutableAttributedString alloc] init];
    [texts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *text = (NSString *)obj;
        //说明是时间字符串
        if ([text integerValue] || [text rangeOfString:@"0"].length) {
            [dateAtt appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:datedic]];
        }else{
            [dateAtt appendAttributedString:[[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor withHexStr:@"737373"]}]];
        }
        
    }];
    return dateAtt;
}
- (NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}
- (NSString *)getEndTimeTimestampWithremainingCollectionTime:(CGFloat)time{
    CGFloat  number = [self getNowTimeTimestamp].floatValue;
    NSString * timeSp = [NSString stringWithFormat:@"%.f", number + time];
    return timeSp;
}

@end
