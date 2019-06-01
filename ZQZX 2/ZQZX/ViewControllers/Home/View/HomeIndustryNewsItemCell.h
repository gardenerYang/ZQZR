//
//  HomeIndustryNewsItemCell.h
//  ZQZX
//
//  Created by yangshuai on 2019/5/30.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeIndustryNewsItemCell : UITableViewCell
@property(nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * moreBtn;
- (instancetype)initWithIndustryArray:(NSMutableArray*)array clickItem:(void (^)(NSInteger tag))clickItem;

@end

NS_ASSUME_NONNULL_END
