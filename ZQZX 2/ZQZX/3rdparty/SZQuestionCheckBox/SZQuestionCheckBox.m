//
//  SZQuestionCheckBox.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/27.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SZQuestionCheckBox.h"
#import "SZQuestionCell.h"
#import "SZQuestionOptionCell.h"
#import "QAHeaderView.h"
#import "QAFooterView.h"
#import "AppUserProfile.h"
#import "HttpRequest+my.h"
#import "MyModel.h"
#import "QAModel.h"
#import "EvaluationResultsVC.h"
@interface SZQuestionCheckBox ()

@property (nonatomic, assign) CGFloat titleWidth;
@property (nonatomic, assign) CGFloat OptionWidth;
@property (nonatomic, assign) BOOL complete;
@property (nonatomic, strong) NSArray *tempArray;
@property (nonatomic, strong) NSMutableArray *arrayM;
@property (nonatomic, strong) SZConfigure *configure;
@property (nonatomic, assign) QuestionCheckBoxType chekBoxType;
@property (nonatomic, strong) MyModel *myModel;
@property (nonatomic, strong) NSMutableArray * selectArray;
@property (nonatomic, assign) BOOL isSelect;
@end

@implementation SZQuestionCheckBox
- (void)markingAnswer{
    if (!self.isSelect) {
        [MBProgressHUD showErrorMessage:@"请勾选投资者风险调查"];
        return;
    }
    if ([self resultArray].count < self.sourceArray.count) {
        [MBProgressHUD showErrorMessage:@"请完整的填写风险调查"];
        return;
    }
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"userId"] = [AppUserProfile sharedInstance].userId;
    dict[@"answerStr"] = [self toJSONData:[self resultArray]];
    [HttpRequest post:my_markingAnswe param:dict success:^(HttpResponse *data,NSString *message) {
        NSLog(@"%@",data.message);
        QAQModel * model = [QAQModel mj_objectWithKeyValues:data.data];
        EvaluationResultsVC * vc = [[EvaluationResultsVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
}
- (NSMutableString *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (instancetype)initWithItem:(SZQuestionItem *)questionItem {
    
    SZConfigure *configure = [[SZConfigure alloc] init];
    return [self initWithItem:questionItem andConfigure:configure];
}

- (instancetype)initWithItem:(SZQuestionItem *)questionItem andConfigure:(SZConfigure *)configure {
    
    return [self initWithItem:questionItem andCheckBoxType:QuestionCheckBoxWithoutHeader andConfigure:configure];
}

- (instancetype)initWithItem:(SZQuestionItem *)questionItem andCheckBoxType:(QuestionCheckBoxType)checkBoxType {
    
    SZConfigure *configure = [[SZConfigure alloc] init];
    return [self initWithItem:questionItem andCheckBoxType:checkBoxType andConfigure:configure];
}


- (instancetype)initWithItem:(SZQuestionItem *)questionItem andCheckBoxType:(QuestionCheckBoxType)checkBoxType andConfigure:(SZConfigure *)configure {
    
    self = [super init];
    
    if (self) {
        self.sourceArray = questionItem.ItemQuestionArray;
        if (configure != nil) self.configure = configure;
        self.chekBoxType = checkBoxType;
    }
    return self;
}
-(void)getMyInformation{
    __weak typeof(self) wf = self;
    
    [HttpRequest getMyInformationRequestsuccess:^(MyModel * _Nonnull myModel, NSString * _Nonnull message) {
        wf.myModel = myModel;
        QAHeaderView * headerView = [[[NSBundle mainBundle] loadNibNamed:@"QAHeaderView" owner:self options:0] lastObject];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 125)];
        [view addSubview:headerView];
        [headerView setFrame:view.bounds];
        headerView.nameLab.text = [NSString stringWithFormat:@"投资者姓名【%@】",myModel.realName];
        headerView.idcardLab.text = [NSString stringWithFormat:@"身份证号码【%@】",[NSString replaceStringWithIDCardString:myModel.idNo]];
        headerView.signLab.text = [NSString stringWithFormat:@"请签名承诺您是为自己购买私募基金产品【%@】",myModel.realName];
        
        QAFooterView * footerView = [[[NSBundle mainBundle] loadNibNamed:@"QAFooterView" owner:self options:0] lastObject];
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 270)];
        [view1 addSubview:footerView];
        [footerView setFrame:view1.bounds];
        NSDate *date=[NSDate date];
        NSDateFormatter *format1=[[NSDateFormatter alloc] init];
        [format1 setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr;
        dateStr=[format1 stringFromDate:date];
        footerView.dateLab.text = [NSString stringWithFormat:@"日期: %@",dateStr];
        footerView.nameLab.text = [NSString stringWithFormat:@"投资者姓名【%@】",myModel.realName];
        [footerView.selectBtn setImage:kImageNamed(@"unchecked.png") forState:(UIControlStateNormal)];
        [footerView.selectBtn setImage:kImageNamed(@"checked.png") forState:(UIControlStateSelected)];
        __weak typeof(footerView) wfooterView = footerView;
        [footerView.selectBtn addTapGestureBlock:^(UIView *view) {
            wfooterView.selectBtn.selected = !wfooterView.selectBtn.selected;
            self.isSelect = wfooterView.selectBtn.selected;
        }];
        self.tableView.tableHeaderView = view;
        self.tableView.tableFooterView = view1;
        
        [footerView.submitBtn addTapGestureBlock:^(UIView *view) {
            NSLog(@"%@",self.resultArray);
            [self markingAnswer];
        }];
    } failure:^(NSError * _Nonnull error) {
        if ([error.localizedDescription isEqualToString:@"请先登录"]) {
            
        }else
        {
            [MBProgressHUD showErrorMessage:error.localizedDescription];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"风险评测"];
    [self getMyInformation];
    self.canEdit = YES;
    self.sourceArray1 = self.sourceArray;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setNavigationControllersWithVC:@"EvaluationResultsVC"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReEvaluate) name:@"ReEvaluate" object:nil];
    
}
- (void)ReEvaluate{
    self.sourceArray = self.sourceArray1;
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.titleWidth = self.view.frame.size.width - self.configure.titleSideMargin * 2;
    self.OptionWidth = self.view.frame.size.width - self.configure.optionSideMargin * 2 - self.configure.buttonSize - 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isComplete {
    
    [self getResult];
    return self.complete;
}

- (NSArray *)resultArray {
    
    [self getResult];
    return self.tempArray;
}

- (void)getResult {
//    {
//        marked =     (
//                      1,
//                      0
//                      );
//        option =     (
//                      "<QAQModel: 0x600003eeba20>",
//                      "<QAQModel: 0x600003eea640>"
//                      );
//        title = "2\U3001\U4e09\U5e74\U5185\U6709\U65e0\U6cd5\U9662\U6c11\U4e8b\U5224\U51b3\Uff1a";
//        type = 1;
//    }
    [self.view endEditing:YES];
    BOOL complete          = true;
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in self.sourceArray) {
        
        if ([dict[@"type"] integerValue] == SZQuestionOpenQuestion) {
            NSString *str = dict[@"marked"];
            complete      = (str.length > 0) && complete;
            [arrayM addObject:str.length ? str : @""];
        }
        else {
            NSArray *array = dict[@"marked"];
            complete       = ([array containsObject:@"YES"] || [array containsObject:@"yes"] || [array containsObject:@(1)] || [array containsObject:@"1"]) && complete;
            
            if (complete ==YES) {
                NSLog(@"%@",array);
                NSInteger dataIndex = [self.sourceArray indexOfObject:dict];
                QAModel * dataModel = self.dataArray[dataIndex];
                if (dataModel.type.integerValue ==1) {
                    //多选
                    NSInteger temScore = 0;
                    NSString *temOption = @"";
                    for (NSInteger i=0; i< array.count; i++) {
                        NSNumber * number = array[i];
                        if (number.integerValue ==1) {
                            NSArray *array1 = dict[@"option"];
                            QAQModel * model = array1[i];
                            temScore = temScore + model.score.integerValue;
                            temOption = [NSString stringWithFormat:@"%@%@",temOption,model.option];
                        }
                    }

                    [arrayM addObject:@{@"answer":temOption,@"eid":dataModel.id,@"score":[NSNumber numberWithInteger:temScore]}];

                }else{
                    
                    NSInteger index = [array indexOfObject:@1];
                    NSArray *array1 = dict[@"option"];
                    QAQModel * model = array1[index];
                    [arrayM addObject:@{@"answer":model.option,@"eid":dataModel.id,@"score":model.score}];
                }
             
            }
     
        }
    }
    self.complete   = complete;
    self.tempArray  = arrayM.copy;
    NSLog(@"%@",arrayM);
}

- (void)setCanEdit:(BOOL)canEdit {
    
    _canEdit = canEdit;
    [self.tableView reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

#pragma mark - UITableViewdatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.chekBoxType == QuestionCheckBoxWithHeader ? self.sourceArray.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        NSDictionary *dict = self.sourceArray[section];
        if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
            return 1;
        }
        else {
            NSArray *optionArray = dict[@"option"];
            return optionArray.count;
        }
    }
    else {
        return self.sourceArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        NSDictionary *dict = self.sourceArray[indexPath.section];
        SZQuestionOptionCell *cell = [[SZQuestionOptionCell alloc]
                                      initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"questionOptionCellIdentifier"
                                      andDict:dict
                                      andIndexPath:indexPath
                                      andWidth:self.view.frame.size.width
                                      andConfigure:self.configure];
        __weak typeof(self) weakSelf = self;
        cell.selectOptionButtonBack = ^(NSIndexPath *indexPath, NSDictionary *dict) {
            [weakSelf.arrayM replaceObjectAtIndex:indexPath.section withObject:dict];
            weakSelf.sourceArray = weakSelf.arrayM.copy;
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
            [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = self.canEdit;
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(12,cell.mj_h , kWidth-12, 0.5)];
        line.backgroundColor = kLineColor;
        [cell addSubview:line];
        return cell;
    }
    else {
        NSDictionary *dict = self.sourceArray[indexPath.row];
        SZQuestionCell *cell = [[SZQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:@"questionCellIdentifier"
                                                             andDict:dict
                                                      andQuestionNum:indexPath.row + 1
                                                            andWidth:self.view.frame.size.width
                                                        andConfigure:self.configure];
        __weak typeof(self) weakSelf = self;
        cell.selectOptionBack = ^(NSInteger index, NSDictionary *dict, BOOL refresh) {
            [weakSelf.arrayM replaceObjectAtIndex:index withObject:dict];
            weakSelf.sourceArray = weakSelf.arrayM.copy;
            NSLog(@"%@",dict);
            if (refresh) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
            }
        };
        UIView*line= [UIView new];
        line.backgroundColor= kLineColor;
        [cell.contentView addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker*make) {
            make.bottom.equalTo(cell.contentView.mas_bottom);
            make.right.equalTo(cell.contentView.mas_right).offset(-12);
            make.left.equalTo(cell.contentView.mas_left).offset(12);
            make.height.offset(.5);
        }];
        cell.titleLab.text = [NSString stringWithFormat:@"%ld/%ld",indexPath.row+1,self.sourceArray.count];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = self.canEdit;

        return cell;
    }
}

#pragma mark - UITableViewdelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        NSDictionary *dict = self.sourceArray[section];
        NSString *title = self.configure.automaticAddLineNumber ? [NSString stringWithFormat:@"%zd、%@", section + 1, dict[@"title"]] : dict[@"title"];
        CGFloat title_height = [SZQuestionItem heightForString:title
                                                         width:self.titleWidth
                                                      fontSize:self.configure.titleFont
                                                 oneLineHeight:self.configure.oneLineHeight];
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        UILabel *lbl =({
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.configure.titleSideMargin, 0, self.titleWidth, title_height)];
            lbl.font = [UIFont systemFontOfSize:self.configure.titleFont];
            lbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            lbl.numberOfLines = 0;
            lbl.text = title;
            lbl;
        });
        [v addSubview:lbl];
        return v;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        NSDictionary *dict = self.sourceArray[section];
        CGFloat title_height = [SZQuestionItem heightForString:dict[@"title"]
                                                         width:self.titleWidth
                                                      fontSize:self.configure.titleFont
                                                 oneLineHeight:self.configure.oneLineHeight];
        return title_height;
    }
    else {
        return 0;
    }
}

/**
 *  返回各个Cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        
        NSDictionary *dict = self.sourceArray[indexPath.section];
        if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
            
            return self.configure.oneLineHeight;
        }
        else {
            
            NSArray *optionArray = dict[@"option"];
            NSString *optionString = [NSString stringWithFormat:@"M、%@", optionArray[indexPath.row]];
            CGFloat option_height = [SZQuestionItem heightForString:optionString width:self.OptionWidth fontSize:self.configure.optionFont oneLineHeight:self.configure.oneLineHeight];
            return option_height;
        }
    }
    else {
        
        CGFloat topDistance = (indexPath.row == 0 ? self.configure.topDistance : 0);
        NSDictionary *dict = self.sourceArray[indexPath.row];
        
        if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
            
            CGFloat title_height = [SZQuestionItem heightForString:dict[@"title"]
                                                             width:self.titleWidth
                                                          fontSize:self.configure.titleFont
                                                     oneLineHeight:self.configure.oneLineHeight];
            if (self.configure.answerFrameFixedHeight && self.configure.answerFrameUseTextView == YES) {
                return title_height + self.configure.answerFrameFixedHeight + 10 + topDistance;
            }
            if ([dict[@"marked"] length] > 0) {
                CGFloat answer_width = self.view.frame.size.width - self.configure.optionSideMargin * 2;
                CGFloat answer_height = [SZQuestionItem heightForString:dict[@"marked"] width:answer_width - 10 fontSize:self.configure.optionFont oneLineHeight:self.configure.oneLineHeight];
                if (self.configure.answerFrameLimitHeight && answer_height > self.configure.answerFrameLimitHeight && self.configure.answerFrameUseTextView == YES) {
                    return title_height + self.configure.answerFrameLimitHeight + 10 + topDistance;
                }
                return title_height + answer_height + 10 + topDistance;
            }
            return title_height + self.configure.oneLineHeight + topDistance;
        }
        else {
            
            CGFloat title_height = [SZQuestionItem heightForString:dict[@"title"]
                                                             width:self.titleWidth
                                                          fontSize:self.configure.titleFont
                                                     oneLineHeight:self.configure.oneLineHeight];
            CGFloat option_height = 0;
            for (NSString *str in dict[@"option"]) {
                NSString *optionString = [NSString stringWithFormat:@"M、%@", str];
                option_height += [SZQuestionItem heightForString:optionString width:self.OptionWidth fontSize:self.configure.optionFont oneLineHeight:self.configure.oneLineHeight];
            }
            return title_height + option_height + topDistance;
        }
    }
}

#pragma mark - 懒加载

- (NSMutableArray *)arrayM {
    
    if (_arrayM == nil) {
        _arrayM = [[NSMutableArray alloc] initWithArray:self.sourceArray];
    }
    return _arrayM;
}
- (NSMutableArray *)selectArray {
    if (_selectArray == nil) {
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _selectArray;
}


@end
