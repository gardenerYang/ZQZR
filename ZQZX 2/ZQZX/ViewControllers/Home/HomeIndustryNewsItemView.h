//
//  HomeIndustryNewsItemView.h
//  ZQZX
//
//  Created by yangshuai on 2019/5/30.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeIndustryNewsItemView : UIView
@property (nonatomic,strong) UIImageView * newsImageV;
//@property (nonatomic,strong) UIImageView * titleImage;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) ListItem * model;
- (instancetype)initWithFrame:(CGRect)frame withModel:(ListItem*)model clickItem:(void (^)(NSInteger tag))clickItem;
@end

NS_ASSUME_NONNULL_END
