//
//  ZHTabBarViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHTabBarViewController.h"
#import "HomeViewController.h"
#import "FindHomeVC.h"
#import "MyViewController.h"
#import "ZHNavigationViewController.h"
#import "MyBusinessViewController.h"
#import "AppUserProfile.h"
#import "ProductHomeVC.h"
@interface ZHTabBarViewController ()<UITabBarControllerDelegate>
{
    
}
@property (strong, nonatomic) HomeViewController *HomeTabVc;
@property (strong, nonatomic) ProductHomeVC *ProductTabVC;
@property (strong, nonatomic) FindHomeVC *FindTabVc;
@property (strong, nonatomic) MyViewController *MyTabVc;
@property (strong, nonatomic) MyBusinessViewController *MyBusinessTabVc;


@end

@implementation ZHTabBarViewController
- (instancetype)initWithType {
    
    if (self = [super init]) {
        
        [self setupSubviews];
        
    }
    return self;
}
-(void)setupSubviews{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoLogoin:)
                                                 name:goToLoginState
                                               object:nil];
    [self setChildVC:self.HomeTabVc title:@"首页" image:@"home_b" selectedImage:@"home_a"];
    [self setChildVC:self.ProductTabVC title:@"产品" image:@"Activity_b" selectedImage:@"Activity_a"];
    [self setChildVC:self.FindTabVc title:@"活动" image:@"find_b" selectedImage:@"find_a"];
    
#if BusinessTag
    [self setChildVC:self.MyBusinessTabVc title:@"我的" image:@"my_b" selectedImage:@"my_a"];
    
#else
    [self setChildVC:self.MyTabVc title:@"我的" image:@"my_b" selectedImage:@"my_a"];
    
#endif
    
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index == 3) {
        if (![AppUserProfile sharedInstance].isLogon) {
            [self toLoginVC];
            return ;
        }
    }
    [self animationWithIndex:index];
}

- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = kTitleColor;
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *selectdict = [NSMutableDictionary dictionary];
    selectdict[NSForegroundColorAttributeName] = kMainColor;
    selectdict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:selectdict forState:UIControlStateSelected];
    
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ZHNavigationViewController *nav = [[ZHNavigationViewController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

#pragma mark 点击动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}
-(HomeViewController*)HomeTabVc{
    _HomeTabVc = [[HomeViewController alloc] init];
    return _HomeTabVc;
}
-(FindHomeVC*)FindTabVc{
    _FindTabVc = [[FindHomeVC alloc] init];
    return _FindTabVc;
}
-(ProductHomeVC*)ProductTabVC{
    _ProductTabVC = [[ProductHomeVC alloc] init];
    return _ProductTabVC;
}
-(MyViewController*)MyTabVc{
    _MyTabVc = [[MyViewController alloc] init];
    return _MyTabVc;
}
-(MyBusinessViewController*)MyBusinessTabVc{
    _MyBusinessTabVc = [[MyBusinessViewController alloc] init];
    return _MyBusinessTabVc;
}
- (void)gotoLogoin:(NSNotification *)notification
{
    [self toLoginVC];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

