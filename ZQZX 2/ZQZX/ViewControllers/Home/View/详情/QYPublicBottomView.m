//
//  MRPublicBottomView.m
//  MRClient
//
//  Created by yangshuai on 2018/7/30.
//  Copyright © 2018年 daniel. All rights reserved.
//

#import "QYPublicBottomView.h"
#define kWhiteColor       [UIColor whiteColor]

@interface QYPublicBottomView()
@property (nonatomic,  copy) NSString * rightString;
@property (nonatomic,  copy) NSString * leftString;
@property (nonatomic,assign) BOOL isCollect;

@end
@implementation QYPublicBottomView

- (instancetype)initWithLeftString:(NSString*)leftString rightString:(NSString*)rightString clickLeftBtn:(clickBottomLeftBtn)leftBtn clickRightBtn:(clickBottomRightBtn)rightBtn{
    self.rightString = rightString;
    self.leftString = leftString;
    self.clickLeftkBtn = leftBtn;
    self.clickRightBtn = rightBtn;
    self = [super initWithFrame:CGRectMake(0, kHeight - kBottomViewHeight, kWidth, kBottomViewHeight)];
    if (self) {
        [self createUI];
    }
    return self;
}
- (instancetype)initWithRightString:(NSString*)string clickBtn:(clickBottomLeftBtn)btn{
    return [self initWithRightString:string leftString:nil clickBtn:btn];
}
- (instancetype)initWithRightString:(NSString *)rightString leftString:(NSString *)leftString clickBtn:(clickBottomLeftBtn)btn{
  return [self initWithLeftString:leftString rightString:rightString clickLeftBtn:nil clickRightBtn:btn];

}
- (void)createUI{
    self.backgroundColor = kWhiteColor;

    UIButton * leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn = leftBtn;
    [self addSubview:leftBtn];
    leftBtn.titleLabel.font = kFont(14);
    leftBtn.backgroundColor = [UIColor withHexStr:@"FFAE00"];
    [leftBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    
    UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn = rightBtn;

    [self addSubview:rightBtn];
    rightBtn.titleLabel.font = kFont(14);
    rightBtn.backgroundColor = [UIColor withHexStr:@"FFAE00"];
    [rightBtn setTitle:self.rightString forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    
    
    if (self.leftString ==nil) {
        //单独一个button样式
        [rightBtn setFrame:CGRectMake(12, self.height-8-44, kWidth - 24, 44)];
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 5.0f;
    }else if (self.clickLeftkBtn ==nil){
        //价格样式
        [rightBtn setFrame:CGRectMake(kWidth/2, 0,kWidth/2, self.height)];
        [leftBtn setTitle:self.leftString forState:(UIControlStateNormal)];
        [leftBtn setFrame:CGRectMake(0, 0, kWidth/2, self.height)];
    }else if (self.clickCollectBtn ==nil){
        leftBtn.backgroundColor = kTabBGColor;
        leftBtn.layer.masksToBounds = YES;
        leftBtn.layer.cornerRadius = 5.0f;
        [leftBtn setTitleColor:kTitleColor forState:(UIControlStateNormal)];
        [leftBtn setTitle:self.leftString forState:(UIControlStateNormal)];
        [leftBtn setFrame:CGRectMake(12, 7.5, (kWidth-36)/2, self.height-15)];
        
        [rightBtn setFrame:CGRectMake(kWidth/2+6, 7.5,(kWidth-36)/2, self.height-15)];
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 5.0f;
    }else{
        [self addSubview:self.collectBtn];
        if (self.style == MRBottomStyleRenewableLease) {
            [rightBtn setFrame:CGRectMake(self.collectBtn.right,0,(kWidth-80), self.height)];
            [rightBtn setTitle:@"已出租" forState:(UIControlStateNormal)];
            rightBtn.userInteractionEnabled = NO;
            [rightBtn setBackgroundColor:kSubtitleColor];
            
        }else{
            leftBtn.backgroundColor = kWhiteColor;
            [leftBtn setTitleColor:kTitleColor forState:(UIControlStateNormal)];
            [leftBtn setTitle:self.leftString forState:(UIControlStateNormal)];
            [leftBtn setFrame:CGRectMake(80, 0, (kWidth-80)/2, self.height)];
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, self.height)];
            [leftBtn addSubview:line];
            line.backgroundColor = kLineColor;
            [rightBtn setFrame:CGRectMake(leftBtn.right,0,(kWidth-80)/2, self.height)];

        }
        
    }
    [leftBtn addTapGestureBlock:^(UIView *view) {
        if (self.clickLeftkBtn) {
            NSLog(@"clickLeftkBtn");
            self.clickLeftkBtn();
        }
    }];
    [rightBtn addTapGestureBlock:^(UIView *view) {
        NSLog(@"clickRightBtn");
        if (self.clickRightBtn) {
            self.clickRightBtn();
        }
    }];
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 0.5)];
    [self addSubview:line];
    line.backgroundColor = kLineColor;
}
- (UIButton *)collectBtn{
    if (_collectBtn ==nil) {
        _collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, self.height)];
        if (_isCollect) {
            [_collectBtn setTitle:@"取消收藏" forState:(UIControlStateNormal)];
        }else{
            [_collectBtn setTitle:@"收藏" forState:(UIControlStateNormal)];
        }
        _collectBtn.selected = _isCollect;
        [_collectBtn setImage:kImageNamed(@"mr_tenement_collect_unselect") forState:(UIControlStateNormal)];
        [_collectBtn setImage:kImageNamed(@"mr_tenement_collect_select") forState:(UIControlStateSelected)];
        _collectBtn.titleLabel.font = kFont(14);
        [_collectBtn setTitleColor:kTitleColor forState:(UIControlStateNormal)];
    }
    return _collectBtn;
}

@end
