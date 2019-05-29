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
        wf.carouselView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        wf.carouselView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
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
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeTableViewCell class])];
    [self.tableView registerClass:[HomeFineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeFineTableViewCell class])];
    [self.tableView registerClass:[HomeButtonTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeButtonTableViewCell class])];
    __weak typeof(self) wf = self;

    [self.tableView addMJ_Header:^{
        [wf getImgData];//获取图片数据
        [wf getHomeData];//获取首页数据
        
    }];
    [self.tableView refresh];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.homeModel.inve.count;
    }
    else{
       return self.homeModel.moments.count;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Iphonewidth, 10)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
        titleLabel.font = [UIFont s16];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.text = @"发现";
        [headerView addSubview:titleLabel];
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setTitle:@"更多>>" forState:UIControlStateNormal];
        [moreBtn setTitleColor:[UIColor m_textGrayColor] forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont s14];
        [moreBtn addAction:^(UIButton *sender) {
            self.tabBarController.selectedIndex = 1;
        }];
        [headerView addSubview:moreBtn];
        [moreBtn setFrame:CGRectMake(Iphonewidth-70, 0, 60, 40)];
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 39, Iphonewidth, 1)];
        lineview.backgroundColor = [UIColor m_lineColor];
        [headerView addSubview:lineview];
        
        return headerView;
    }
    else{
        return nil;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSArray *titleArr = [NSArray arrayWithObjects:@"票据投资",@"保理投资",@"股权投资",@"银行产品", nil];
        NSArray *selectArr = [NSArray arrayWithObjects:@"piaoju_b",@"bao_b",@"gu_b",@"wallet", nil];
        NSArray *noselectArr = [NSArray arrayWithObjects:@"piaoju_a",@"bao_a",@"gu_a",@"wallet", nil];
        
        HomeButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeButtonTableViewCell class]) forIndexPath:indexPath];
        cell.backgroundColor=[UIColor m_bgColor];
        
        
        __weak typeof(self) wf = self;
        [cell setBtnTitle:titleArr selectImgArr:selectArr imgArr:noselectArr color:[UIColor blackColor]];
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
    }
   else if (indexPath.section == 1) {
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeTableViewCell class]) forIndexPath:indexPath];
        cell.backgroundColor=[UIColor m_bgColor];
       InveItem *model  = self.homeModel.inve[indexPath.row];
       NSString *title;
       if (@(model.type).intValue == 0) {
           title = @"票据投资";
       }else if (@(model.type).intValue == 1){
           title = @"保理投资";

       }else if (@(model.type).intValue == 2){
           title = @"房产投资";

       }else{
           title = @"股权投资";

       }
       cell.titleLabel.text = title;
       cell.numTitleLb.text =  [NSString stringFormatPercentNumberWithFloat:@(model.expectedYield).floatValue];
       cell.dayLb.text = [NSString stringWithFormat:@"%ld天",(long)model.projectDuration];
       cell.moneyLb.text = [NSString stringWithFormat:@"%@起投",[self moneyStr:model.purchaseAmount]];
       cell.titleLb.text = model.name;
       timeModel *timemodel = self.timeListArr[indexPath.row];
       [cell.timeLb setupCellWithModel:timemodel indexPath:indexPath];
       cell.timeLb.attributedText = [self.countDown countDownWithTimeLabel:cell.timeLb];
       cell.moneyLb.text =[NSString stringWithFormat:@"%@起投",[self moneyStr:model.purchaseAmount]];
       CGFloat per = (model.actualTotalAmount-model.reservationAmount)/model.proTotalAmount;
       NSLog(@"%f",per);
       cell.progressView.progress = per;
       NSString * perString = @"%";
       cell.progressLabel.text = [NSString stringWithFormat:@"预约进度:%.f%@",per*100,perString];
       NSString *stateText;
       if (@(model.status).intValue == 1) {
           stateText = @"募集中";
       }else if (@(model.status).intValue == 4){
           stateText = @"还款中";
           cell.stateLb.backgroundColor = [UIColor withHexStr:@"#469ee8"];
       }else if (@(model.status).intValue == 3){
           stateText = @"已募满";
       }
       else if (@(model.status).intValue == 6){
           stateText = @"已还款";
       }
       else {
           stateText = @"";
       }
       cell.stateLb.text = stateText;
       if (model.platformRateYear > 0) {
           cell.interestsLb.hidden = NO;
       }else{
           cell.interestsLb.hidden = YES;
       }
       [cell setMorebtnClickBlock:^{
           if (@(model.type).intValue == 1) {
               InvestmentViewController *investmentVC =[[InvestmentViewController alloc]initType:@(model.type).stringValue];
               investmentVC.type = model.type;
               [investmentVC setCustomerTitle:title];
               [self.navigationController pushViewController:investmentVC animated:YES];
           }
           else{
               HomeListViewController *homeListVC = [[HomeListViewController alloc]init];
               [homeListVC setCustomerTitle:title];
               homeListVC.type1 = @"0";
               homeListVC.type2 = @"4";
               [self.navigationController pushViewController:homeListVC animated:YES];
           }
       }];

        return cell;
    }
    else{
        HomeFineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeFineTableViewCell class]) forIndexPath:indexPath];
        cell.backgroundColor=[UIColor m_bgColor];
        MomentsItem *model  = self.homeModel.moments[indexPath.row];
        [cell.imgView sd_setNewsImageWithString:model.imageUrl];
        cell.titleLabel.text = model.title;
        cell.timeLabel.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.addTime] withType:kTimeStampDateOnlyTextLine];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 40;
    }
    return 0.1;
    
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
