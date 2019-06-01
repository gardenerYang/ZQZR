//
//  HomeCorporateNewsCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/5/30.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "HomeCorporateNewsCell.h"

@implementation HomeCorporateNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = NO;
}

- (void)setModel:(ListItem *)model{
    self.news_title.text = model.title;
    [self.news_image sd_setImageWithURL:kURL(model.imageUrl) placeholderImage:kNewsPlaceholderImage];
}

@end
