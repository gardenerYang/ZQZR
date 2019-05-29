//
//  MyBusinessOrderdetailsVC.m
//  ZQZX_Business
//
//  Created by 中企 on 2018/10/23.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "MyBusinessOrderdetailsVC.h"
#import "OrderdetailsCell1.h"
#import "MyBusinessOrderdetailsCell.h"
#import "LLImagePickerView.h"
#import "BusinessCardViewController.h"
#import "BusinessOrderdetailsModel.h"
#import "HttpRequest+MyBusiness.h"
#import "ActionSheetPicker.h"
#import "QNManage.h"
#import "HttpRequest+QN.h"
#import "SuccessViewController.h"
#import "UIView+Extension.h"
@interface MyBusinessOrderdetailsVC ()
@property(nonatomic,strong)BusinessOrderdetailsModel *model;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSString *time;;
@property(nonatomic,strong)NSString *dBankcard;
@property(nonatomic,strong)NSString *hBankcard;
@property(nonatomic,strong)NSString *bankStr;//银行地方字符串

@property(nonatomic,strong)NSArray *bankCardArr;//银行卡列表
@property(nonatomic,strong)QNModel *qnModel;
@property(nonatomic,strong)NSString *imgStr;//凭证
@property(nonatomic,strong)NSMutableArray *imgArr;//其他凭证
@property(nonatomic,strong)NSArray *imgArray;//其他凭证

@property(nonatomic,strong)NSString *moneyStr;//金额
@property(nonatomic,strong)UIButton *submissionBtn;//提交
@property(nonatomic,strong)NSString *remitWay;//打款方式
@property(nonatomic,strong)NSString *remitWaySting;//打款方式


@end

@implementation MyBusinessOrderdetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"订单详情"];
    _dataArr = @[@"待受理",@"待签约",@"已签约",@"签约作废",@"签约不成功",@"已取消",@"已退款",@"待赎回",@"已赎回",@"待还款",@"已还款",@"待签约"];
    _bankCardArr =[[NSArray alloc]init];
    _imgArr = [[NSMutableArray alloc]init];
    [self setTableViewEdges:UIEdgeInsetsMake(0, 0,0, 0)];
    [self.tableView registerClass:[OrderdetailsCell1 class] forCellReuseIdentifier:NSStringFromClass([OrderdetailsCell1 class])];
    [self.tableView registerClass:[MyBusinessOrderdetailsCell class] forCellReuseIdentifier:NSStringFromClass([MyBusinessOrderdetailsCell class])];
    __weak typeof(self) weakSelf = self;
    [self.tableView addMJ_Header:^{
        [weakSelf requestList];
    }];
    [self.tableView refresh];
    [[QNManage sharedInstance] upManager];
    [self getQNUploadtoken];

}
-(void)getQNUploadtoken{
    [HttpRequest getQNTokenRequestsuccess:^(QNModel * _Nonnull model, NSString * _Nonnull message) {
        self.qnModel = model;
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}
-(void)requestList
{
    __weak typeof(self) wf = self;
    [HttpRequest mygetBusinessBillDetailById:/*@"1"*/_ordID Requestsuccess:^(BusinessOrderdetailsModel * _Nonnull model, NSString * _Nonnull message) {
        [wf.tableView stopReload];
        wf.model = model;
        wf.time = [wf parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)model.addTime] withType:kTimeStampDateOnlyHorizonLine];
        wf.dBankcard = model.remitBankNo;
        wf.hBankcard = model.repaymentBankNo;
        wf.bankStr = model.bank;
        wf.moneyStr = [self appointmentMoneyStr:model.subscribeAmount] ;
        [wf getCardList:@(model.id).stringValue];
        [self addtabFootView];
        [wf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [wf.tableView stopReload];
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
    
}
-(void)getCardList:(NSString *)userID{
    __weak typeof(self)wf = self;
    [HttpRequest getBankcardListID:userID Requestsuccess:^(NSArray * _Nonnull dataArr, NSString * _Nonnull message) {
        wf.bankCardArr = dataArr;
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}
-(void)addtabFootView
{
    __weak typeof(self) wf = self;
   UIView *footView = [[UIView alloc]init];
    UILabel *titleLb1=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, Iphonewidth-20, 40)];
    titleLb1.font = [UIFont s16];
    titleLb1.textColor=[UIColor blackColor];
    titleLb1.textAlignment=NSTextAlignmentLeft;
    titleLb1.text = @"上传打款凭证";
    [footView addSubview:titleLb1];
    
    LLImagePickerView *pickerV = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(0, 60, Iphonewidth, 0) CountOfRow:3];
    pickerV.type = LLImageTypePhotoAndCamera;
    pickerV.maxImageSelected = 1;
    if (self.model.certificateUrl.length > 0) {
        self.imgStr = self.model.certificateUrl;
        pickerV.preShowMedias = @[self.model.certificateUrl];
    }
    pickerV.allowPickingVideo = NO;
    pickerV.showDelete = YES;
    [pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
    NSLog(@"%@",list);
        if (list.count ==0) {
            return ;
        }
        LLImagePickerModel *model = list[0];
        [[QNManage sharedInstance]qiuNiu:model.image token:self.qnModel.token url:self.qnModel.doman success:^(NSString * _Nonnull imgurl) {
            self.imgStr = imgurl;
        } failure:^(NSError * _Nonnull err) {
            [MBProgressHUD showErrorMessage:@"上传失败"];
        }];
    }];
    [footView addSubview:pickerV];
    
    
    UILabel *titleLb=[[UILabel alloc]initWithFrame:CGRectMake(10, pickerV.frame.size.height + 70, Iphonewidth-20, 40)];
    titleLb.font = [UIFont s16];
    titleLb.textColor=[UIColor blackColor];
    titleLb.textAlignment=NSTextAlignmentLeft;
    titleLb.text = @"上传其他照片";
    [footView addSubview:titleLb];

    LLImagePickerView *pickerV1 = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(0, pickerV.frame.size.height + 70 + 50, Iphonewidth, 0) CountOfRow:3];
    pickerV1.type = LLImageTypePhotoAndCamera;
    pickerV1.maxImageSelected = 8;
    pickerV1.allowPickingVideo = NO;
    [pickerV1 observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        self.imgArray = list;
    }];
    [footView addSubview:pickerV1];
    
    _submissionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submissionBtn setBackgroundColor:[UIColor m_red]];
    [_submissionBtn setTitle:@"提交" forState:UIControlStateNormal];
    _submissionBtn.layer.masksToBounds = YES;
    _submissionBtn.layer.cornerRadius = 25;
    [_submissionBtn addAction:^(UIButton *sender) {
        if (wf.bankStr.length == 0) {
            [MBProgressHUD showErrorMessage:@"请输入回款开户行"];
            return;
        }
        if (self.imgStr.length == 0) {
            [MBProgressHUD showWarnMessage:@"请上传打款凭证"];
            return;
        }
        if (self.dBankcard.length ==0){
            [MBProgressHUD showErrorMessage:@"请选择打款银行卡"];
            return;
        }
        if (self.hBankcard.length ==0){
            [MBProgressHUD showErrorMessage:@"请选择回款银行卡"];
            return;
        }
        if (self.remitWay.length ==0) {
            [MBProgressHUD showErrorMessage:@"请选择打款方式"];
            return;
        }
        wf.submissionBtn.userInteractionEnabled = NO;
        [MBProgressHUD showActivityMessageInView:@"正在提交..."];
        if (wf.imgArray.count>0) {
            for (LLImagePickerModel *model in wf.imgArray) {
                [[QNManage sharedInstance]qiuNiu:model.image token:wf.qnModel.token url:wf.qnModel.doman success:^(NSString * _Nonnull imgurl) {
                    [wf.imgArr addObject:imgurl];
                    if (wf.imgArr.count == wf.imgArray.count) {
                        [wf submitData];
                    }
                } failure:^(NSError * _Nonnull err) {
                    [MBProgressHUD showErrorMessage:@"上传失败"];
                }];
            }
        }else{
            [wf submitData];
        }


    }];
    [footView addSubview:_submissionBtn];
   
    _submissionBtn.frame = CGRectMake(40, pickerV1.frame.size.height + pickerV.frame.size.height + 70 + 50 +10, Iphonewidth-80, 50);
    
    footView.frame = CGRectMake(0, 0, Iphonewidth, _submissionBtn.frame.size.height + _submissionBtn.frame.origin.y +20);
    [pickerV1 observeViewHeight:^(CGFloat height) {
        CGRect rect = pickerV1.frame;
        rect.size.height = CGRectGetMaxY(pickerV1.frame);
        wf.submissionBtn.frame = CGRectMake(40, rect.size.height + 40  , Iphonewidth-80, 50);
        
        footView.frame = CGRectMake(0, 0, Iphonewidth, wf.submissionBtn.frame.size.height + wf.submissionBtn.frame.origin.y +20);
        self.tableView.tableFooterView = footView;
    }];
    self.tableView.tableFooterView = footView;

}
- (void)submitData{
    [HttpRequest submissioninformationID:@(self.model.id).stringValue remitBankNo:self.dBankcard repaymentBankNo:self.hBankcard payTime:self.time certificateUrl:self.imgStr bankInfo: self.bankStr certificateUrlOther:[self.imgArr componentsJoinedByString:@","] actualAmount:self.moneyStr remitWay:self.remitWay Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
        [MBProgressHUD hideHUD];
        self.submissionBtn.userInteractionEnabled = NO;
        
        SuccessViewController *successVC=[[SuccessViewController alloc]init];
        successVC.titleLbText = @"提交成功";
        successVC.srcLbText = @"即将返回";
        [successVC setOtherblock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [successVC showInVC:self];
        
    } failure:^(NSError * _Nonnull error) {
        self.submissionBtn.userInteractionEnabled = YES;
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        OrderdetailsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderdetailsCell1 class]) forIndexPath:indexPath];
        cell.titleLb.text = self.model.productName;
        cell.orderNumLb.text = [NSString stringWithFormat:@"订单编号  %@",_model.investmentNo] ;
        NSInteger rows = _model.status;
        cell.tagLb.text = _dataArr[rows];
        cell.numView.srcLabel.text = [self annualRate:_model.rateYear];
        cell.deadlineView.srcLabel.text = [NSString stringWithFormat:@"%@天",_model.projectDuration];
        cell.moneyView.srcLabel.text = [self appointmentMoneyStr:_model.subscribeAmount];;
        cell.timeView.srcLabel.text = [self parseTimeStamp:[NSString stringWithFormat:@"%ld",(long)_model.addTime] withType:kTimeStampDateOnlyHorizonLine];
        cell.stateView.srcLabel.text = _dataArr[rows];
        cell.nameView.srcLabel.text = [self name:_model.realName];
        cell.phoneiew.srcLabel.text = [self phone: _model.phone];
        return cell;
    }else if (indexPath.row == 1){
        MyBusinessOrderdetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyBusinessOrderdetailsCell class]) forIndexPath:indexPath];
        cell.titleLb.text = @"打款银行卡";
        cell.textField.placeholder = @"请选择银行卡号";
        cell.textField.userInteractionEnabled = NO;
        cell.textField.text = _dBankcard;
        return cell;
    }else if (indexPath.row == 2){
        MyBusinessOrderdetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyBusinessOrderdetailsCell class]) forIndexPath:indexPath];
        cell.titleLb.text = @"回款银行卡";
        cell.textField.placeholder = @"请选择银行卡号";
        cell.textField.userInteractionEnabled = NO;
        cell.textField.text = _hBankcard;

        return cell;
    }else if (indexPath.row == 3){
        MyBusinessOrderdetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyBusinessOrderdetailsCell class]) forIndexPath:indexPath];
        cell.titleLb.text = @"回款开户行";
        cell.textField.placeholder = @"请精确到支行";
        [cell.textField addTarget:self action:@selector(inputDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.textField.userInteractionEnabled = YES;

        cell.textField.text = _bankStr;
        
        return cell;
    }
    else if (indexPath.row == 4){
        MyBusinessOrderdetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyBusinessOrderdetailsCell class]) forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.titleLb.text = @"用户打款金额";
        cell.textField.placeholder = @"";
       
        cell.textField.text = [self appointmentMoneyStr:_model.subscribeAmount] ;
        cell.textField.textColor = [UIColor m_Lightred];
        cell.textField.userInteractionEnabled = NO;

        return cell;
    }else if (indexPath.row == 5){
        MyBusinessOrderdetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyBusinessOrderdetailsCell class]) forIndexPath:indexPath];
        cell.titleLb.text = @"打款日期";
        cell.textField.placeholder = @"请选择打款日期";
        cell.textField.text = _time;
        cell.textField.userInteractionEnabled = NO;
        cell.textField.textColor = [UIColor blackColor];
        return cell;
    }else{
        MyBusinessOrderdetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyBusinessOrderdetailsCell class]) forIndexPath:indexPath];
        cell.titleLb.text = @"打款方式";
        cell.textField.placeholder = @"请选择打款方式";
        cell.textField.text = _remitWaySting;
        cell.textField.userInteractionEnabled = NO;
        cell.textField.textColor = [UIColor blackColor];
        return cell;
    }
    
}
- (void)inputDidChange:(UITextField *)senderField {
    _bankStr = senderField.text;

  
}
//MARK: delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self)wf = self;
    if ( indexPath.row == 1) {
        BusinessCardViewController *paymentVC=[[BusinessCardViewController alloc]init];
        paymentVC.bankCardArr = wf.bankCardArr;
        [paymentVC setCallBack:^(NSString * _Nonnull bankCard) {
            wf.dBankcard = bankCard;
            wf.hBankcard = bankCard;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            MyBusinessOrderdetailsCell *tfCell = [self.tableView cellForRowAtIndexPath:indexPath];
            tfCell.textField.text = bankCard;
            
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:2 inSection:0];
            MyBusinessOrderdetailsCell *tfCell1 = [self.tableView cellForRowAtIndexPath:indexPath1];
            tfCell1.textField.text = bankCard;
            
        }];
        [paymentVC showInVC:(ZHViewController *)[UIApplication sharedApplication].keyWindow.rootViewController];
    } else  if ( indexPath.row == 2) {
        BusinessCardViewController *paymentVC=[[BusinessCardViewController alloc]init];
        paymentVC.bankCardArr = wf.bankCardArr;

        [paymentVC setCallBack:^(NSString * _Nonnull bankCard) {
            wf.hBankcard = bankCard;
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:2 inSection:0];
            MyBusinessOrderdetailsCell *tfCell1 = [self.tableView cellForRowAtIndexPath:indexPath1];
            tfCell1.textField.text = bankCard;
        }];
        
        [paymentVC showInVC:(ZHViewController *)[UIApplication sharedApplication].keyWindow.rootViewController];
    }
    else  if ( indexPath.row == 5){
        NSDate* curDate = [NSDate date];
        //datePickerMode可以设置时间类型
        ActionSheetDatePicker* picker = [[ActionSheetDatePicker alloc] initWithTitle:nil
                                                                      datePickerMode:UIDatePickerModeDate
                                                                        selectedDate:curDate
                                                                           doneBlock:^(ActionSheetDatePicker* picker, NSDate* selectedDate, id origin) {
                                                                               NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                                                               //设置格式：zzz表示时区
                                                                               [dateFormatter setDateFormat:@"yyyy-MM-dd "];
                                                                               //NSDate转NSString
                                                                               NSString *currentDateString = [dateFormatter stringFromDate:selectedDate];
                                                                               NSLog(@"----------%@",currentDateString);                                                                                _time = currentDateString;
                                                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
                                                                               MyBusinessOrderdetailsCell *tfCell = [self.tableView cellForRowAtIndexPath:indexPath];
                                                                  tfCell.textField.text = currentDateString;
                                                                               
                                                                           } cancelBlock:^(ActionSheetDatePicker* picker) {
                                                                               
                                                                           }                                                             origin:self.view];
        [picker showActionSheetPicker];
    }else if (indexPath.row ==6){
        //打款方式
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"请选择打款方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"银行转账" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了按钮1，进入按钮1的事件");
            self.remitWay = @"0";
            self.remitWaySting = @"银行转账";
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            MyBusinessOrderdetailsCell *tfCell = [self.tableView cellForRowAtIndexPath:indexPath];
            tfCell.textField.text = self.remitWaySting;
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"刷POS机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.remitWay = @"1";
            self.remitWaySting = @"刷POS机";
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            MyBusinessOrderdetailsCell *tfCell = [self.tableView cellForRowAtIndexPath:indexPath];
            tfCell.textField.text = self.remitWaySting;
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"汇款" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.remitWay = @"2";
            self.remitWaySting = @"汇款";
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            MyBusinessOrderdetailsCell *tfCell = [self.tableView cellForRowAtIndexPath:indexPath];
            tfCell.textField.text = self.remitWaySting;
        }];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
        }];
        //把action添加到actionSheet里
        [actionSheet addAction:action1];
        [actionSheet addAction:action2];
        [actionSheet addAction:action3];
        [actionSheet addAction:action4];
        [self presentViewController:actionSheet animated:YES completion:nil];
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
