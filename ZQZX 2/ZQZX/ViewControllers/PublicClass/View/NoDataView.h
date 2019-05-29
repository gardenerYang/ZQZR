//
//  NoDataView.h
//  Ninesecretary
//
//  Created by chenglian on 2017/7/4.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NoDataType) {
    NoDataTypeSelected,
    NoDataTypeDefault,
};

/**
 定制无数据显示类型
 - NoDataDetailTypeDefault: 默认显示
 - NoDataDetailTypeNews: 无消息显示
 - NoDataDetailTypeShopping: 商城无物品显示
 */
typedef NS_ENUM(NSUInteger, NoDataDetailType) {
    NoDataDetailTypeDefault,
    NoDataDetailTypeNews,
    NoDataDetailTypeShopping,
};

@interface NoDataView : UIView

@property (nonatomic, strong) UIImageView   *imgView;
@property (nonatomic, strong) UILabel       *titleLb;
@property (nonatomic, strong) UIButton      *detailBtn;
@property (nonatomic, copy) void            (^toEnter)(void);
@property (nonatomic, copy) void            (^reloadData)(void);

- (instancetype)initWithType:(NoDataType)type;

@end
