//
//  CapitalRecordTableViewCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/1/29.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "CapitalRecordTableViewCell.h"

@interface CapitalRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *detailContainerViewHeightConstraint;
@end
@implementation CapitalRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.withDetails = NO;
    self.backgroundView = nil;
    self.detailContainerViewHeightConstraint.constant = 0;
    
}

#pragma mark Set with details
- (void)setWithDetails:(BOOL)withDetails {
    _withDetails = withDetails;
    if (withDetails) {
        self.detailContainerViewHeightConstraint.priority = 250;
    } else {
        self.detailContainerViewHeightConstraint.priority = 999;
    }
}

#pragma mark Animated open cell

- (void)animateOpen {
    UIColor *originalBackgroundColor = self.contentView.backgroundColor;
    self.contentView.backgroundColor = [UIColor clearColor];
    //    [self.detailContainerView foldOpenWithTransparency:YES
    //                                   withCompletionBlock:^{
    // _buttonIcon.imageView.image = [UIImage imageNamed:@"expandGlyphUp"];
    self.contentView.backgroundColor = originalBackgroundColor;
    _imageIcon.image = [UIImage imageNamed:@"selectCity_top"];
    //                                   }];
}

#pragma mark Animated closed cell

- (void)animateClosed {
    UIColor *originalBackgroundColor = self.contentView.backgroundColor;
    self.contentView.backgroundColor = [UIColor clearColor];
    
    //    [self.detailContainerView foldClosedWithTransparency:YES withCompletionBlock:^{
    //_buttonIcon.imageView.image = [UIImage imageNamed:@"expandGlyph"];
    self.contentView.backgroundColor = originalBackgroundColor;
    _imageIcon.image = [UIImage imageNamed:@"selectCity_bottom"];
    //    }];
}

@end
