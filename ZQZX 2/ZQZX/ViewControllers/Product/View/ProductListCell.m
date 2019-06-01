//
//  ProductListCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "ProductListCell.h"

@implementation ProductListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = NO;
    self.backgroundColor = kTabBGColor;
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
