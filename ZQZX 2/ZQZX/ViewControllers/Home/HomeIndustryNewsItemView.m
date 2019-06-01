//
//  HomeIndustryNewsItemView.m
//  ZQZX
//
//  Created by yangshuai on 2019/5/30.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "HomeIndustryNewsItemView.h"

@implementation HomeIndustryNewsItemView

- (instancetype)initWithFrame:(CGRect)frame withModel:(ListItem*)model clickItem:(void (^)(NSInteger tag))clickItem{
    self= [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        [self.titleLabel setTextColor:kTitleColor];
        self.titleLabel.font = kFont(9);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        self.newsImageV = [[UIImageView alloc]init];
        [self addSubview:self.newsImageV];
        [self.newsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self.titleLabel.mas_top).offset(-10);
        }];
        self.titleLabel.text = model.title;
        [self.newsImageV sd_setImageWithURL:kURL(model.coverImageUrl) placeholderImage:kNewsPlaceholderImage];
        @weakify(self);
        [self addTapGestureBlock:^(UIView *view) {
            @strongify(self);
            clickItem(self.tag);
        }];
    }
    return self;
}


@end
