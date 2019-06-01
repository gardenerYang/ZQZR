//
//  SuccessViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/11.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "SuccessViewController.h"
#import "SKPopAnimationMange.h"

@interface SuccessViewController ()
@property (nonatomic, strong) UIView    *bgView;
/**
 主标题
 */
@property (nonatomic, strong) UILabel   *titleLb;
/**
 副标题文本
 */
@property (nonatomic, strong) UILabel   *srcLb;
@property (nonatomic, strong) UIImageView   *imgView;
@property (nonatomic, strong) SKPopAnimationMange   *animationMange;
@property (nonatomic, strong) UIButton   *nextBtn;
@property (nonatomic, assign) SuccessType   type;


@end

@implementation SuccessViewController

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
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:_imgName.length ==0 ? @"success" : _imgName];
    [self.bgView addSubview:self.imgView];
    
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
  
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(Iphonewidth==320 ? 250 : 300);
        make.height.mas_equalTo(Iphonewidth==320 ? 166 : 200);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.mas_equalTo(self.bgView);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [self.srcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    if (_type == SuccessTypeBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle: _btnTitle forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont s16];
        _nextBtn.layer.cornerRadius = 20.0;
        _nextBtn.backgroundColor = _btnBgColor;
        __weak typeof(self) wf = self;

        [_nextBtn addAction:^(UIButton *sender) {
            if (wf.tapBtnblock) {
                wf.tapBtnblock();
            }
        }];
        [self.bgView addSubview:_nextBtn];
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.srcLb.mas_bottom).offset(10);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(40);
        }];
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            make.width.mas_equalTo(Iphonewidth==320 ? 250 : 300);
            make.height.mas_equalTo(Iphonewidth==320 ? 200 : 220);
        }];
    }
   
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
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){//此处是几秒后执行操作
        //执行事件
        if (self.Otherblock) {
            self.Otherblock();
        }
    });
    
   
}
- (void)showInVC:(ZHViewController *)vc type:(SuccessType )type{
    _type = type;
    [self showInVC:vc];
    
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
-(void)setImgName:(NSString *)imgName{
    _imgName = imgName;
}
-(void)setBtnTitle:(NSString *)btnTitle
{
    _btnTitle = btnTitle;
}
-(void)setBtnBgColor:(UIColor *)btnBgColor
{
    _btnBgColor = btnBgColor;
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
