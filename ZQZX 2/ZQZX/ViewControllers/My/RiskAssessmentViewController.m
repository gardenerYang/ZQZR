//
//  RiskAssessmentViewController.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "RiskAssessmentViewController.h"
#import "SZQuestionCheckBox.h"

@interface RiskAssessmentViewController ()
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *optionArray;

@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, strong) SZQuestionCheckBox *questionBox;

@property (nonatomic, strong) NSArray *resultArray;
@end

@implementation RiskAssessmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomerTitle:@"风险评估"];
}


@end
