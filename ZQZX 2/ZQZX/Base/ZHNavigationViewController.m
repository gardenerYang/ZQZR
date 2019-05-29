//
//  ZHNavigationViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHNavigationViewController.h"

@interface ZHNavigationViewController ()

@end

@implementation ZHNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
}
- (void)popToBack
{
    if (self.viewControllers.count == 1) {
        [[self.viewControllers firstObject] dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self popViewControllerAnimated:YES];
    }
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        
        __weak typeof(self) wf = self;
        [viewController setLeftBarButtonItemWithImg:@"back" selector:^(id sender) {
            [wf popToBack];
        }];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
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
