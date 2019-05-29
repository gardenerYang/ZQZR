//
//  BusinessHeaderView.m
//  ZQZX_Business
//
//  Created by 中企 on 2018/10/22.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BusinessHeaderView.h"

@implementation BusinessHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.header = [[MyBusinessHeadView alloc] initWithFrame:self.frame];
    [self addSubview:self.header];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.header.frame = frame;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.header.frame = layoutAttributes.bounds;
}

@end
