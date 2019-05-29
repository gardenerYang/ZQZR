//
//  HomeUpdateVC.m
//  ZQZX
//
//  Created by yangshuai on 2019/2/15.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "HomeUpdateVC.h"

@interface HomeUpdateVC ()
/** 版本号 */
@property (nonatomic, copy) NSString *version;
/** 版本更新内容 */
@property (weak, nonatomic) IBOutlet UIView *line;
@property (nonatomic, copy) NSString *desc;
@end

@implementation HomeUpdateVC
- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.shadeView.alpha = 0.5f;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 9.0f;
    self.bgView.clipsToBounds = NO;
    self.contentView.textContainer.lineFragmentPadding = 0;
    self.contentView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentView.editable = NO;
    self.contentView.selectable = NO;
    self.contentView.scrollEnabled = NO;
    self.contentView.showsVerticalScrollIndicator = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    [self.closeBtn addTapGestureBlock:^(UIView *view) {
        [self dismissAlert];
    }];
    [self.shadeView addTapGestureBlock:^(UIView *view) {
        [self dismissAlert];
    }];
    [self.leftBtn addAction:^(UIButton * _Nonnull sender) {
        [self dismissAlert];

    }];

}

/**
 添加版本更新提示
 
 @param version 版本号
 @param descriptions 版本更新内容（数组）
 
 descriptions 格式如 @[@"1.xxxxxx",@"2.xxxxxx"]
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Descriptions:(NSArray *)descriptions
{
    if (!descriptions || descriptions.count == 0) {
        return;
    }
    
    //数组转换字符串，动态添加换行符\n
    NSString *description = @"";
    for (NSInteger i = 0;  i < descriptions.count; ++i) {
        id desc = descriptions[i];
        if (![desc isKindOfClass:[NSString class]]) {
            return;
        }
        description = [description stringByAppendingString:desc];
        if (i != descriptions.count-1) {
            description = [description stringByAppendingString:@"\n"];
        }
    }
    HomeUpdateVC *updateAlert = [[HomeUpdateVC alloc]initVersion:version description:description isCompulsion:NO click:nil];
    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
}

/**
 添加版本更新提示
 
 @param version 版本号
 @param description 版本更新内容（字符串）
 
 description 格式如 @"1.xxxxxx\n2.xxxxxx"
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description isCompulsion:(BOOL)isCompulsion clikRightBtn:(ClickRightBtn)clikRightBtn{
    HomeUpdateVC *updateAlert = [[HomeUpdateVC alloc]initVersion:version description:description isCompulsion:isCompulsion click:clikRightBtn];
    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
}
- (instancetype)initVersion:(NSString *)version description:(NSString *)description isCompulsion:(BOOL)isCompulsion click:(ClickRightBtn)clikRightBtn
{
    HomeUpdateVC *updateAlert = [[[NSBundle mainBundle] loadNibNamed:@"HomeUpdateVC" owner:self options:0] lastObject];
    self.version = version;
    self.desc = description;
    [updateAlert setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    updateAlert.versionLabel.text = self.version;
    updateAlert.contentView.text = self.desc;
    [updateAlert.rightBtn addTapGestureBlock:^(UIView *view) {
        if (clikRightBtn) {
            if (!isCompulsion) {
                [updateAlert dismissAlert];                
            }
            clikRightBtn();
        }
    }];
    [self setupUI];
    if (isCompulsion) {
        updateAlert.leftBtn.hidden = YES;
        updateAlert.shadeView.userInteractionEnabled = NO;
        updateAlert.rightBtnWidth.constant = 246;
        updateAlert.line.hidden = YES;
    }
    return updateAlert;
}
- (void)setupUI{
    self.versionLabel.text = self.version;
    self.contentView.text = self.desc;
}
/** 添加Alert出场动画 */
- (void)dismissAlert{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

@end
