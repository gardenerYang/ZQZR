//
//  TipsViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "TipsViewController.h"
#import "SKPopAnimationMange.h"

@interface TipsViewController ()
@property (nonatomic, strong) UIView    *bgView;
/**
 主标题
 */
@property (nonatomic, strong) UILabel   *titleLb;
/**
 副标题文本
 */
@property (nonatomic, strong) UILabel   *srcLb;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UIView   *line1View;

@property (nonatomic, strong) SKPopAnimationMange   *animationMange;
/**
 取消
 */
@property (nonatomic, strong) UIButton   *cancelBtn;
/**
 确定
 */
@property (nonatomic, strong) UIButton   *confirmBtn;

@end

@implementation TipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius=5;
    self.bgView.layer.masksToBounds=YES;
    [self.view addSubview:self.bgView];
    
    
    _titleLb = [[UILabel alloc]init];
    _titleLb.text = _titleLbText;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:_titleLb];
    
    _srcLb = [[UILabel alloc]init];
    _srcLb.text = _srcLbText;
    _srcLb.textAlignment = NSTextAlignmentCenter;
    _srcLb.textColor = kLightGray;
    _srcLb.font = [UIFont s14];
    [self.bgView addSubview:_srcLb];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor m_lineColor];
    [self.bgView addSubview:_lineView];
    
    _line1View = [[UIView alloc]init];
    _line1View.backgroundColor = [UIColor m_lineColor];
    [self.bgView addSubview:_line1View];
    
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle: @"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont s16];
    _cancelBtn.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) wf = self;
    
    [_cancelBtn addAction:^(UIButton *sender) {
        [wf dismiss];
        if (wf.tapCancelBtnblock) {
            wf.tapCancelBtnblock();
        }
    }];
    [self.bgView addSubview:_cancelBtn];
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle: @"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont s16];
    _confirmBtn.backgroundColor = [UIColor whiteColor];
    
    [_confirmBtn addAction:^(UIButton *sender) {
         [wf dismiss];
        if (wf.tapConfirmBtnblock) {
            wf.tapConfirmBtnblock();
        }
    }];
    [self.bgView addSubview:_confirmBtn];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(Iphonewidth==320 ? 250 : 300);
        make.height.mas_equalTo(Iphonewidth==320 ? 150 : 150);
    }];
    
   
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [self.srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
   [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.srcLb.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(1);
    }];
    
    [self.line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.left.mas_equalTo(self.bgView.mas_centerX);
        make.bottom.mas_equalTo(0);
        make.width.mas_offset(1);
    }];
    
     [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.right.mas_equalTo(self.line1View.mas_left);
        make.bottom.mas_equalTo(0);
        make.left.mas_offset(0);
        make.height.mas_equalTo(60);

    }];

    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.left.mas_equalTo(self.line1View.mas_right);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(60);
        make.right.mas_offset(0);
    }];
    
}
- (void)showInVC:(ZHViewController *)vc {
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.animationMange = [[SKPopAnimationMange alloc] init];
    self.animationMange.type = SK_ANIMATION_TYPE_ROTATION;
    self.animationMange.animationDirection = SK_ANIMATION_SUBTYPE_FROMTOP;
    
    [self.animationMange animateWithView:self.bgView Duration:0.3 animationType:self.animationMange.type animationDirection:self.animationMange.animationDirection];
}
- (void)dismiss {
    [self.animationMange dismissAnimationForRootView:self.bgView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view removeFromSuperview];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *view = [[touches anyObject] view];
    
    if ([view isEqual:self.view]) {
        [self dismiss];
    }
}
-(void)setSrcLbText:(NSString *)srcLbText{
    _srcLbText = srcLbText;
}
-(void)setTitleLbText:(NSString *)titleLbText{
    
    _titleLbText = titleLbText;
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
