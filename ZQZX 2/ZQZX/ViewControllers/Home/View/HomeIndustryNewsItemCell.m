//
//  HomeIndustryNewsItemCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/5/30.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "HomeIndustryNewsItemCell.h"
#import "HomeIndustryNewsItemView.h"
@interface HomeIndustryNewsItemCell()

@end
@implementation HomeIndustryNewsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        self.backgroundColor = kTabBGColor;
    }
    return self;
}
- (void)createUI{
    self.selectionStyle = NO;
    self.titleLabel = [[UILabel alloc]init];
    [self addSubview:self.titleLabel];
    self.titleLabel.text = @"行业新闻";
    self.titleLabel.textColor = kTitleColor;
    self.titleLabel.font = kFont(17);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(20);
    }];
    
    self.moreBtn = [[UIButton alloc]init];
    [self addSubview:self.moreBtn];
    [self.moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
    [self.moreBtn setTitleColor:kSubtitleColor forState:(UIControlStateNormal)];
    self.moreBtn.titleLabel.font = kF12;
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.titleLabel);
    }];
    CGFloat itemWidth = (kWidth-60)/3;
    CGFloat itemHeight = itemWidth*185/120;
    self.scrollView = [[UIScrollView alloc]init];
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(15);
        make.height.mas_equalTo(itemHeight);
    }];
    [self.scrollView setContentSize:CGSizeMake(10000, itemHeight)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i =0; i<3; i++) {
  
        HomeIndustryNewsItemView * itemView = [[HomeIndustryNewsItemView alloc]initWithFrame:CGRectMake(15+(itemWidth*i)+(15*i), 0, itemWidth, itemHeight)];
        
        [self.scrollView addSubview:itemView];
    }
    
}
@end
