//
//  EvaluationResultsVC.h
//  ZQZX
//
//  Created by yangshuai on 2019/1/24.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
#import "LCStarRatingView.h"
#import "QAModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EvaluationResultsVC : ZHViewController
@property (weak, nonatomic) IBOutlet LCStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UILabel *resultsLab;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *afresh;
@property (nonatomic,strong) QAQModel * model;
@property (nonatomic,assign) BOOL isQuestionDone;
@end

NS_ASSUME_NONNULL_END
