//
//  JMHUDView.h
//  NinesecretaryBusiness
//
//  Created by JG on 2017/11/28.
//  Copyright © 2017年 九秘. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS (NSInteger, JMHUDType)
{
    JMHUDTypeLoading = 0,
    JMHUDTypeSuccess = 1,
    JMHUDTypeError   = 2,
    JMHUDTypeMessage = 3,
};

@interface JMHUDView : UIView

@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) JMHUDType hudViewType;

- (instancetype)init;
- (void)setType:(JMHUDType)type message:(NSString *)message;
- (void)showInView:(UIView *)view;
- (void)dismissWithComplete:(void (^)(void))complete;
- (void)dismiss;
@end




