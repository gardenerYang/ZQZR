//
//  ZHSegmentView.h
//  Ninesecretary
//
//  Created by chenglian on 2017/6/19.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHSegmentDelegate;

@interface ZHSegmentView : UIView
//segment 点击按钮触发事件代理
@property(nonatomic,assign)id<ZHSegmentDelegate> delegate;
//segment 文字数组
@property(nonatomic,strong)NSArray *titleArray;
//segment 文字颜色
@property(nonatomic,strong)UIColor *titleNormalColor;
//segment 选中时文字颜色
@property(nonatomic,strong)UIColor *titleSelectColor;
//segment 文字字体，默认15
@property(nonatomic,strong)UIFont  *titleFont;
//segment 默认选中按钮/视图 1
@property(nonatomic,assign)NSInteger defaultSelectIndex;
//视图偏移时，控件随着发生变化
-(void)ZHDidScrollChangeTheTitleColorWithContentOfSet:(CGFloat)width;
-(void)mainViewScrollDidScroll:(NSInteger )tag;

@end
@protocol ZHSegmentDelegate <NSObject>

@required
-(void)ZHSegment:(ZHSegmentView *)segment didSelectIndex:(NSInteger)index;

@end

