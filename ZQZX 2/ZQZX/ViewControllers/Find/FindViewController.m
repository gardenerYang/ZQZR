//
//  FindViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "FindViewController.h"
#import <WMPageController/WMPageController.h>
#import "FindChildrenViewController.h"
#import "WMPanGestureRecognizer.h"
#import "UIImageView+SD.h"
static CGFloat const kWMMenuViewHeight = 60.0;

@interface FindViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *musicCategories;
@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, assign) float kWMHeaderViewHeight;
@property (nonatomic, strong) NSString *url;//点击跳转的URL
@property (nonatomic, strong) NSString *content;//点击跳转的内容

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self initUI];
}
- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"行业新闻", @"公司动态"];
    }
    return _musicCategories;
}

- (instancetype)init {
    if (self = [super init]) {
        _kWMHeaderViewHeight = (Iphonewidth-20)*0.261;
        
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
        self.viewTop = _kWMHeaderViewHeight;
//        self.titleColorSelected = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
//        self.titleColorNormal = [UIColor colorWithRed:0.4 green:0.8 blue:0.1 alpha:1.0];
    }
    return self;
}
- (void)initUI {
    //[self.navigationController setNavigationBarHidden:YES];
    [self setCustomerTitle:@"发现"];
    
    _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, Iphonewidth-20, (Iphonewidth-20)*0.261)];
//    _headImgView.image = [UIImage imageNamed:@"headbg"];
    _headImgView.backgroundColor = [UIColor m_bgColor];
    [self.view addSubview:_headImgView];
    
    UITapGestureRecognizer* singleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer1.numberOfTapsRequired = 1;// 单击
    [_headImgView addGestureRecognizer:singleRecognizer1];
    _headImgView.userInteractionEnabled=YES;
    
//    _headImgView.layer.shadowOffset =  CGSizeMake(1,10);
//    _headImgView.layer.shadowOpacity = 0.6;
//    _headImgView.layer.shadowColor =  [UIColor m_Lightred].CGColor;
    
    self.titleColorSelected = [UIColor m_red];
    self.titleColorNormal = [UIColor colorWithRed:0.4 green:0.8 blue:0.1 alpha:1.0];
    
   
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];;
  
}
/**
 头部点击

 @param recognizer recognizer description
 */
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    [self gotoWebURL:self.url htmlText:self.content  title:@""];
}
- (void)panOnView:(WMPanGestureRecognizer *)recognizer {
    NSLog(@"pannnnnning received..");
    
    CGPoint currentPoint = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.lastPoint = currentPoint;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat targetPoint = velocity.y < 0 ? 0 : _kWMHeaderViewHeight;
        NSTimeInterval duration = fabs((targetPoint - self.viewTop) / velocity.y);
        
        if (fabs(velocity.y) * 1.0 > fabs(targetPoint - self.viewTop)) {
            NSLog(@"velocity: %lf", velocity.y);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.viewTop = targetPoint;
            } completion:nil];
            
            return;
        }
        
    }
    CGFloat yChange = currentPoint.y - self.lastPoint.y;
    
    self.viewTop += yChange;
    self.lastPoint = currentPoint;
}

// MARK: ChangeViewFrame (Animatable)
- (void)setViewTop:(CGFloat)viewTop {
    _viewTop = viewTop;
    
    if (_viewTop <= 0) {
        _viewTop = 0;
    }
    
    if (_viewTop > _kWMHeaderViewHeight ) {
        _viewTop = _kWMHeaderViewHeight ;
    }
    
    self.headImgView.frame = ({
        CGRect oriFrame = self.headImgView.frame;
        oriFrame.origin.y = _viewTop - _kWMHeaderViewHeight ;
        oriFrame;
    });
    
    [self forceLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    __weak typeof(self) wf = self;
    FindChildrenViewController *vc = [[FindChildrenViewController alloc] init:@(index + 1 ).stringValue];

    [vc setBackImgblock:^(NSString * _Nonnull bannerUrl, NSString * _Nonnull Url, NSString * _Nonnull content) {
        wf.content = content;
        wf.url = Url;
        [wf.headImgView sd_setFindImageWithString:bannerUrl];
    }];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, _viewTop , self.view.frame.size.width, kWMMenuViewHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = _viewTop + kWMMenuViewHeight ;
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
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
