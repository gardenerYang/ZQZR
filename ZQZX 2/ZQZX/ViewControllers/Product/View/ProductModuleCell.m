//
//  ProductModuleCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "ProductModuleCell.h"

@implementation ProductModuleCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier imageArray:(NSArray*)imageArray{
    self = [super initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        self.backgroundColor = kTabBGColor;
        CGFloat imageWidth = (kWidth-45)/2;
        UIImageView * leftImageV = [[UIImageView alloc]initWithImage:kImageNamed(imageArray[0])];
        [self addSubview:leftImageV];
        leftImageV.layer.masksToBounds = YES;
        leftImageV.layer.cornerRadius = 5.0f;
        self.leftImageV = leftImageV;
        [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(15);
            make.bottom.equalTo(self).offset(-15);
            make.width.mas_equalTo(imageWidth);
        }];
        [self addShadowWith:leftImageV];
        
        UIImageView * rightImageV = [[UIImageView alloc]initWithImage:kImageNamed(imageArray[1])];
        [self addSubview:rightImageV];
        rightImageV.layer.cornerRadius = 5.0f;
        self.rightImageV = rightImageV;
        [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftImageV.mas_right).offset(15);
            make.top.equalTo(self).offset(15);
            make.bottom.equalTo(self).offset(-15);
            make.width.mas_equalTo(imageWidth);
        }];
        [self addShadowWith:rightImageV];

    }
    return self;
}
- (void)addShadowWith:(UIImageView*)imageV{
    imageV.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影偏移量
    imageV.layer.shadowOffset = CGSizeMake(0,0);
    // 设置阴影透明度
    imageV.layer.shadowOpacity = 0.6;
    // 设置阴影半径
    imageV.layer.shadowRadius = 5;
    imageV.clipsToBounds = NO;
}
@end
