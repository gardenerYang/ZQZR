//
//  HomeIndustryNewsItemView.m
//  ZQZX
//
//  Created by yangshuai on 2019/5/30.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "HomeIndustryNewsItemView.h"

@implementation HomeIndustryNewsItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        [self createUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)createUI{
    self.titleLabel = [[UILabel alloc]init];
    [self addSubview:self.titleLabel];
    [self.titleLabel setTextColor:kTitleColor];
    self.titleLabel.font = kFont(9);
    self.titleLabel.text = @"sdfsdfsdf";
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.right.equalTo(self).offset(-15);
    }];
    
    self.titleImage = [[UIImageView alloc]init];
    [self addSubview:self.titleImage];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-10);
    }];
    self.titleImage.image = kImageNamed(@"finance");
    
    self.newsImageV = [[UIImageView alloc]init];
    [self addSubview:self.newsImageV];
    [self.newsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.titleImage.mas_top).offset(-15);
    }];
    self.newsImageV.backgroundColor = [UIColor redColor];
}
@end
