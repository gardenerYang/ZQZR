//
//  MyBusinessOrderTwodetailsVC.m
//  ZQZX
//
//  Created by 中企 on 2018/11/2.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessOrderTwodetailsVC.h"
#import "OrderdetailsCell1.h"
#import "OrderdetailsCell2.h"
#import "OrderTextLabel.h"
#import "OrderdetailsCell3.h"
#import "CancelOderViewController.h"
#import "BusinessOrderdetailsModel.h"
#import "HttpRequest+MyBusiness.h"
#import <Photos/Photos.h>
#import "MWCommon.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>
@interface MyBusinessOrderTwodetailsVC ()<MWPhotoBrowserDelegate>
@property(nonatomic,assign)BOOL isClick;
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)NSMutableArray *dataListArr;
@property(nonatomic,strong)BusinessOrderdetailsModel *model;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic, retain) NSArray *photos;

@end

@implementation MyBusinessOrderTwodetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle: @"我的订单"];
    _dataArr = @[@"待受理",@"待签约",@"已签约",@"签约作废",@"签约不成功",@"已取消",@"已退款",@"待赎回",@"已赎回",@"待还款",@"已还款",@"待签约"];

    _isClick = NO;
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[OrderdetailsCell1 class] forCellReuseIdentifier:NSStringFromClass([OrderdetailsCell1 class])];
    [self.tableView registerClass:[OrderdetailsCell2 class] forCellReuseIdentifier:NSStringFromClass([OrderdetailsCell2 class])];
    [self.tableView registerClass:[OrderdetailsCell3 class] forCellReuseIdentifier:NSStringFromClass([OrderdetailsCell3 class])];
//    [self setupFootVie];
    __weak typeof(self) weakSelf = self;
    [self.tableView addMJ_Header:^{
        weakSelf.dataListArr=[[NSMutableArray alloc]init];
        [weakSelf requestList];
    }];
    [self.tableView refresh];
}
-(void)requestList
{
    __weak typeof(self) wf = self;
    
    [HttpRequest mygetBusinessBillDetailById:_ordID Requestsuccess:^(BusinessOrderdetailsModel * _Nonnull model, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        wf.model = model;
        wf.model = model;
        if (model.status == 0) {
            wf.cancelBtn.hidden = NO;
        }
        [wf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [wf.tableView stopReload];
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
 
}
-(void)setupFootVie{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, 200)];
    footview.userInteractionEnabled = YES;
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setBackgroundColor:[UIColor withHexStr:@"#c0bab7"]];
    [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor withHexStr:@"#746560"] forState:UIControlStateNormal];
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 30;
    __weak typeof(self) wf = self;
    [_cancelBtn addAction:^(UIButton *sender) {
        [MBProgressHUD showActivityMessageInView:@"正在提交..."];
        
      /*  [HttpRequest cancelOrderID:wf.ordID Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccessMessage:@"订单取消成功"];
            [wf.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD showErrorMessage:error.localizedDescription];
        }];
        //        CancelOderViewController *CancelOderVC = [[CancelOderViewController alloc]init];
        //        [wf.navigationController pushViewController:CancelOderVC animated:YES];*/
    }];
    _cancelBtn.hidden = YES;
    [footview addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(-40);
    }];
    self.tableView.tableFooterView=footview;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 && _isClick) {
        return 1;
    }
    else if (section == 2 && !_isClick)
    {
        return 0;
    }
    else
    {
        return 1;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Iphonewidth, 40)];
        
        OrderTextLabel *headerView = [[OrderTextLabel alloc] initWithType];
        headerView.frame = CGRectMake(0, 0, Iphonewidth-20, 40);
        headerView.titleLabel.text = @"用户打款凭证";
        headerView.srcLabel.text = @"点击打开";
        _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed: _isClick ?  @"open": @"close"]];
        _img.frame = CGRectMake(Iphonewidth-21, 17, 11, 6);
        [view addSubview:_img];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        __weak typeof(self) wf = self;
        [btn addAction:^(UIButton *sender) {
            if (wf.isClick) {
                wf.isClick = NO;
                wf.img.image =[UIImage imageNamed:@"close"];
            }
            else{
                wf.isClick = YES;
                wf.img.image =[UIImage imageNamed:@"open"];
                
            }
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
            [wf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        }];
        [headerView addSubview:btn];
        btn.frame=view.frame;
        [view addSubview:headerView];
        return view;
        
        
        
    }
    else{
        return nil;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 40;
    }
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        OrderdetailsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderdetailsCell1 class]) forIndexPath:indexPath];
        cell.titleLb.text = _model.productName;
        cell.orderNumLb.text = [NSString stringWithFormat:@"订单编号 %@",_model.investmentNo] ;
        NSInteger rows = _model.status;
        cell.tagLb.text = _dataArr[rows];
        cell.numView.srcLabel.text = [self annualRate:_model.rateYear];
        cell.moneyView.srcLabel.text =  [self appointmentMoneyStr:_model.subscribeAmount];
        cell.timeView.srcLabel.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)_model.addTime] withType:kTimeStampDateOnlyHorizonLine];
        cell.deadlineView.srcLabel.text = [NSString stringWithFormat:@"%@天",_model.projectDuration];
        cell.stateView.srcLabel.text = _dataArr[rows];
        cell.nameView.srcLabel.text = [self name:_model.realName];
        cell.phoneiew.srcLabel.text = [self phone: _model.phone];
        
        return cell;
    }else if (indexPath.section ==1){
        OrderdetailsCell2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderdetailsCell2 class]) forIndexPath:indexPath];
        cell.car1View.srcLabel.text = _model.remitBankNo;
        cell.car2View.srcLabel.text = _model.repaymentBankNo;
        cell.carPlace2View.srcLabel.text = _model.bank;
        cell.moneyView.srcLabel.text = [NSString stringFormatNumberWithFloat:[[NSString stringWithFormat: @"%ld", (long)_model.actualAmount] floatValue]];
        cell.timeView.srcLabel.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)_model.payTime] withType:kTimeStampDateOnlyHorizonLine];
        
        return cell;
    }else{
        OrderdetailsCell3 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderdetailsCell3 class]) forIndexPath:indexPath];
        
        [cell.bgImgView sd_setBigImageWithString:_model.certificateUrl];
        return cell;
    }
    
    
    
}

//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==2) {
    NSMutableArray *photos = [[NSMutableArray alloc] init];
//    MWPhoto *photo, *thumb;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:_model.certificateUrl]]];
    self.photos = photos;
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
    }
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
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
