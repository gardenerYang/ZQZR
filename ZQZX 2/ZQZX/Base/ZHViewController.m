//
//  ZHViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/10.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"

@interface ZHViewController ()

@end

@implementation ZHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor withHexStr:@"feffff"];
    self.edgesForExtendedLayout = UIRectEdgeNone;

}
-(void)ZHNavigationBarHidden:(BOOL)IsHidden
{
    if (IsHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
    }
    else
    {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
    }
    
}
- (void)setNavigationControllersWithVC:(NSString*)classString{
    Class vcClass = NSClassFromString(classString);
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[vcClass class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
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
