//
//  RemindListSelectView.m
//  ZQZX
//
//  Created by yangshuai on 2019/4/19.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "RemindListSelectView.h"
#import "UIButton+YSTool.h"

@implementation RemindListSelectView


- (instancetype)initWithFrame:(CGRect)frame withOption:(NSInteger)option{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIWithOption:option];
        NSLog(@"=======%ld",option);
    }
    return self;
}
-(void)setIsInvest:(BOOL)isInvest{
    _isInvest = isInvest;
    if (_isInvest) {
        [_topBtn setTitle:@"续  投" forState:(UIControlStateNormal)];
        [_topBtn setTitleColor:[UIColor withHexStr:@"fb6b31"] forState:(UIControlStateNormal)];
        [_bottomBtn setTitle:@"不续投" forState:(UIControlStateNormal)];
        [_bottomBtn setTitleColor:kSubtitleColor forState:(UIControlStateNormal)];
        [_topBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _topBtn.imageView.image.size.width, 0, _topBtn.imageView.image.size.width)];
        [_topBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _topBtn.titleLabel.bounds.size.width+10, 0, -_topBtn.titleLabel.bounds.size.width)];
    }else{
        [_topBtn setTitle:@"不续投" forState:(UIControlStateNormal)];
        [_topBtn setTitleColor:kSubtitleColor forState:(UIControlStateNormal)];
        [_bottomBtn setTitle:@"续  投" forState:(UIControlStateNormal)];
        [_bottomBtn setTitleColor:[UIColor withHexStr:@"fb6b31"] forState:(UIControlStateNormal)];
        [_topBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _topBtn.imageView.image.size.width, 0, _topBtn.imageView.image.size.width)];
        [_topBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _topBtn.titleLabel.bounds.size.width+10, 0, -_topBtn.titleLabel.bounds.size.width)];
    }
}
- (void)createUIWithOption:(NSInteger)option{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.0f;
    self.layer.borderWidth = 0.5f;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor withHexStr:@"fb6b31"].CGColor;
    __weak typeof(self) wf = self;
    _topBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    [_topBtn setImage:kImageNamed(@"remind_down") forState:(UIControlStateNormal)];
    _topBtn.titleLabel.font = kFont(14);
    [self addSubview:_topBtn];

    
    _bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 30, self.width, 30)];
    [self addSubview:_bottomBtn];
    _bottomBtn.titleLabel.font = kFont(14);

    self.isInvest = option;
    
    [self.bottomBtn addTapGestureBlock:^(UIView *view) {
        [wf remindrecover];
        wf.isInvest = !wf.isInvest;
        if (wf.selectOption) {
            wf.selectOption(wf.isInvest);
        }
    }];
    [self.topBtn addTapGestureBlock:^(UIView *view) {
        if ([wf image:wf.topBtn.imageView.image isEqualTo:kImageNamed(@"remind_down")]) {
            if (wf.topBtn.selected) {
                [wf.topBtn setImage:kImageNamed(@"remind_up") forState:(UIControlStateSelected)];
            }else{
                [wf.topBtn setImage:kImageNamed(@"remind_up") forState:(UIControlStateNormal)];
            }
        }else{
            if (wf.topBtn.selected) {
                [wf.topBtn setImage:kImageNamed(@"remind_down") forState:(UIControlStateSelected)];
            }else{
                [wf.topBtn setImage:kImageNamed(@"remind_down") forState:(UIControlStateNormal)];
            }
        }
        if (wf.isUnfold) {
            [wf remindrecover];
        }else{
            [wf remindUnfold];
        }
        if (wf.selectOption) {
            wf.selectOption(wf.isInvest);
        }
    }];

}
//展开
- (void)remindUnfold{
    self.isUnfold = YES;
    self.bottomBtn.hidden = NO;
    [self.topBtn setImage:kImageNamed(@"remind_up") forState:(UIControlStateNormal)];
    [UIView animateWithDuration:0.3 animations:^{
        [self setHeight:60];
    }];
}
- (void)remindrecover{
    self.isUnfold = NO;
    self.bottomBtn.hidden = YES;
    [self.topBtn setImage:kImageNamed(@"remind_down") forState:(UIControlStateNormal)];
    [UIView animateWithDuration:0.3 animations:^{
        [self setHeight:30];
    }];
}

- (BOOL)image:(UIImage*)image1 isEqualTo:(UIImage*)image2{
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    return[data1 isEqual:data2];
    
}

@end
