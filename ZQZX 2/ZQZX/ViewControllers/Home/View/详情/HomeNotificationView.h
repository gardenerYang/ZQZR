//
//  HomeNotificationView.h
//  ZQZX
//
//  Created by yangshuai on 2019/4/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNotificationView : UIView
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
