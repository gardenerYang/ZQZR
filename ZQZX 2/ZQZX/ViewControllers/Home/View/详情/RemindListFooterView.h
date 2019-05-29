//
//  RemindListFooterView.h
//  ZQZX
//
//  Created by yangshuai on 2019/4/21.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RemindListFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *treatyBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic,strong) void (^ clickBtn) (NSInteger option);

@end

NS_ASSUME_NONNULL_END
