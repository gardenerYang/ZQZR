//
//  HomeButtonTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeButtonTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *BKView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, copy) void            (^btnClickBlock)(NSUInteger selectClick);
-(void)setBtnTitle:(NSArray *)title selectImgArr:(NSArray *)selectArr imgArr:(NSArray *)imgArr color:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
