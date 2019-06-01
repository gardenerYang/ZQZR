//
//  EvaluationResultsVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/24.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "EvaluationResultsVC.h"
#import "LCStarRatingView.h"
#import "SZQuestionItem.h"
#import "HttpRequest+my.h"
#import "SZQuestionCheckBox.h"
@interface EvaluationResultsVC ()
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *optionArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *typeArray;
@end

@implementation EvaluationResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}
- (void)requestData{
    [MBProgressHUD showActivityMessageInView:@"获取评测结果中"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"userId"] = [AppUserProfile sharedInstance].userId;
    [HttpRequest post:my_getInvestorQReslt param:dict success:^(HttpResponse *data, NSString *message) {
        self.model = [QAQModel mj_objectWithKeyValues:data.data];
        [MBProgressHUD hideHUD];
        [self setupUI];
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:error.localizedDescription];
        [MBProgressHUD hideHUD];
    }];
}
- (void)setupUI{
    [self setCustomerTitle:@"风险评测结果"];
    self.view.backgroundColor = kTabBGColor;
    self.starView.starColor = [UIColor whiteColor];
    self.starView.starBorderColor = kMainColor;
    self.starView.starBorderWidth = 1;
    self.starView.starPlaceHolderBorderColor = kMainColor;
    self.starView.starPlaceHolderBorderWidth = 1;
    self.starView.type  = LCStarRatingViewCountingTypeFloat;
    self.starView.progress = 5 - (self.model.score.floatValue/20);
    self.starView.starPlaceHolderColor = kMainColor;
    
    self.typeLab.text = self.model.clientType;
    self.scoreLab.text = [NSString stringWithFormat:@"%@分",self.model.score];
    self.resultsLab.text = self.model.tips;
    NSArray *array = [self.model.tips componentsSeparatedByString:@": "];
    NSString * typeString = array.lastObject;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.model.tips];
    NSRange range1 = [[str string] rangeOfString:typeString];
    [str addAttribute:NSForegroundColorAttributeName value:kMainColor range:range1];
    self.resultsLab.attributedText = str;
    [self.doneBtn addTapGestureBlock:^(UIView *view) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setTabIndex" object:nil];
    }];
    [self.afresh addTapGestureBlock:^(UIView *view) {
        if (self.isQuestionDone) {
            self.titleArray = [NSMutableArray array];
            self.optionArray = [NSMutableArray array];
            self.dataArray = [NSMutableArray array];
            self.typeArray = [NSMutableArray array];
            [MBProgressHUD showActivityMessageInView:@"正在请求"];
            [HttpRequest getQuestionList:[AppUserProfile sharedInstance].userId Requestsuccess:^(NSMutableArray * _Nonnull data, NSString * _Nonnull message) {
                [MBProgressHUD hideHUD];
                for (QAModel * model in data) {
                    [self.titleArray addObject:model.content];
                    [self.optionArray addObject:model.investAnswers];
                    [self.dataArray addObject:model];
                    [self.typeArray addObject:model.type];
                }
                
                SZQuestionItem *item = [[SZQuestionItem alloc] initWithTitleArray:self.titleArray andOptionArray:self.optionArray  andResultArray:nil andQuestonTypes:self.typeArray];
                SZQuestionCheckBox * questionBox = [[SZQuestionCheckBox alloc] initWithItem:item];
                questionBox.dataArray = self.dataArray;
                [self.navigationController pushViewController:questionBox animated:YES];
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD showErrorMessage:error.localizedDescription];
            }];

        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ReEvaluate" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
