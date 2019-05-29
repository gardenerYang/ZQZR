//
//  MRPublicBottomView.h
//  MRClient
//
//  Created by yangshuai on 2018/7/30.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MRBottomStyle) {
    MRBottomStyleNormal = 1,
    MRBottomStyleMoney,//有价钱样式
    MRBottomStyleDoubleButton,//两个按钮都可点击
    MRBottomStyleCollect,//详情页收藏样式
    MRBottomStyleRenewableLease,//详情页不可出租

};
typedef void (^clickBottomLeftBtn)(void);
typedef void (^clickBottomCollectBtn)(void);

typedef void (^clickBottomRightBtn)(void);

@interface QYPublicBottomView : UIView
- (instancetype)initWithCollectBtn:(BOOL)isCollect bottomStyle:(MRBottomStyle)style clickCollectBtn:(clickBottomCollectBtn)collectBtn clickLeftBtn:(clickBottomLeftBtn)leftBtn clickRightBtn:(clickBottomRightBtn)rightBtn;
- (instancetype)initWithLeftString:(NSString*)leftString rightString:(NSString*)rightString clickLeftBtn:(clickBottomLeftBtn)leftBtn clickRightBtn:(clickBottomRightBtn)rightBtn;
- (instancetype)initWithRightString:(NSString*)string clickBtn:(clickBottomLeftBtn)btn;
- (instancetype)initWithRightString:(NSString *)rightString leftString:(NSString *)leftString clickBtn:(clickBottomLeftBtn)btn;
@property (nonatomic,strong) clickBottomLeftBtn clickLeftkBtn;
@property (nonatomic,strong) clickBottomRightBtn clickRightBtn;
@property (nonatomic,strong) clickBottomCollectBtn clickCollectBtn;
@property (nonatomic,strong) UIButton * collectBtn;
@property (nonatomic,strong) UIButton * leftBtn;
@property (nonatomic,strong) UIButton * rightBtn;

@property (nonatomic,assign) MRBottomStyle  style;
@end
