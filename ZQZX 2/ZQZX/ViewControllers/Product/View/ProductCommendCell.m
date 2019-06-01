//
//  ProductCommendCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/6/1.
//  Copyright © 2019 ZhangHaoHao. All rights reserved.
//

#import "ProductCommendCell.h"

@implementation ProductCommendCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier imageString:(NSString*)image{
    self = [super initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = NO;
        self.backgroundColor = kTabBGColor;
        UIImageView * imageV = [[UIImageView alloc]initWithImage:kImageNamed(image)];
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);

        }];
    }
    return self;
}

@end
