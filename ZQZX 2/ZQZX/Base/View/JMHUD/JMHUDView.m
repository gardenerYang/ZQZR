//
//  JMHUDView.m
//  NinesecretaryBusiness
//
//  Created by JG on 2017/11/28.
//  Copyright © 2017年 九秘. All rights reserved.
//

#import "JMHUDView.h"

#define HUD_WIDTH 200
#define HUD_HEIGHT 50
#define ICON_WIDTH 50
#define FONT_SIZE 14

@interface TipsLabel: UILabel

@property(nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation TipsLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = self.edgeInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets) limitedToNumberOfLines:numberOfLines];
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end

@interface JMHUDView ()
@property (nonatomic, strong) UIVisualEffectView    *bgEffectView;
@property (nonatomic, strong) UIView        *effectView;
@property (nonatomic, strong) UIView        *bgView;
@property (nonatomic, weak) UIView          *parent;
@property (nonatomic, strong) UIImageView   *icon;
@property (nonatomic, strong) TipsLabel     *tipsLabel;
@end

@implementation JMHUDView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.bgView = [[UIView alloc] init];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.bgEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    self.effectView = [[UIView alloc] init];
    self.effectView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    self.icon = [[UIImageView alloc] init];
    self.icon.frame = CGRectMake(0, 0, 40, 40);
    self.tipsLabel = [[TipsLabel alloc] init];
    self.tipsLabel.numberOfLines = 0;
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
    self.tipsLabel.textColor = kTitleColor;
    self.tipsLabel.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark 设置self的layer
- (void)resetLayer {
    self.bgEffectView.layer.cornerRadius = 5;
    self.bgEffectView.layer.masksToBounds = YES;
    self.bgView.layer.shadowColor      = [UIColor m_textLighGrayColor].CGColor;
    self.bgView.layer.shadowOffset     = CGSizeMake(0, 0);
    self.bgView.layer.shadowRadius     = 5;
    self.bgView.layer.cornerRadius     = 5;
    self.bgView.layer.shadowOpacity    = 1;
}

- (void)setupFrame:(CGRect)frame {
    self.bgView.frame = frame;
    self.bgEffectView.frame = frame;
    self.effectView.frame = frame;
}

#pragma mark 设置type
- (void)setType:(JMHUDType)type message:(NSString *)message {
    [self resetFrameWithMessage:message];
    [self resetLayer];
    
    switch (type) {
        case JMHUDTypeLoading:
        {
            [self showLoadingAnimation];
            self.icon.image = [UIImage imageNamed:@"HUDLoading_1"];
        }
            break;
        case JMHUDTypeSuccess:
        {
            [self.icon.layer removeAllAnimations];
            self.icon.image = [UIImage imageNamed:@"HUDSuccess_1"];
        }
            break;
        case JMHUDTypeError:
        {
            [self.icon.layer removeAllAnimations];
            self.icon.image = [UIImage imageNamed:@"HUDError_1"];
        }
            break;
        case JMHUDTypeMessage:
        {
            [self.icon.layer removeAllAnimations];
            self.icon.image = [UIImage imageNamed:@"HUDMessage_1"];
        }
            break;
        default:
            break;
    }
}


#pragma mark 设置各个控件的frame
- (void)resetFrameWithMessage:(NSString *)message
{
    CGSize labelSize = [self getTheRealHeightAndWidthWithMessage:message];
    if (labelSize.height <= HUD_WIDTH)
    {
        if (self.tipsLabel.numberOfLines > 1)
        {
            self.tipsLabel.frame = CGRectMake(ICON_WIDTH, 0, HUD_WIDTH, labelSize.height);
            self.tipsLabel.center = CGPointMake(ICON_WIDTH + HUD_WIDTH/2, 25);
            self.icon.center = CGPointMake(25, 25);
            [self setupFrame:CGRectMake(0, 0, HUD_WIDTH + ICON_WIDTH, HUD_HEIGHT)];
        }
        else
        {
            self.tipsLabel.frame = CGRectMake(ICON_WIDTH, 0, HUD_WIDTH, labelSize.height);
            self.tipsLabel.center =CGPointMake(ICON_WIDTH + labelSize.width/2, 25);
            self.icon.center = CGPointMake(25, 25);
            [self setupFrame:CGRectMake(0, 0, labelSize.width + ICON_WIDTH, HUD_HEIGHT)];
        }
    }
    else
    {
        self.tipsLabel.frame = CGRectMake(ICON_WIDTH, 0, HUD_WIDTH, labelSize.height);
        self.tipsLabel.center = CGPointMake(ICON_WIDTH + labelSize.width/2, labelSize.height/2);
        self.icon.center = CGPointMake(25, labelSize.height/2);
        [self setupFrame:CGRectMake(0, 0, labelSize.width + ICON_WIDTH, labelSize.height)];
    }
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.bgEffectView];
    [self.bgEffectView.contentView addSubview:self.effectView];
    
    self.tipsLabel.text = message;
    [self.bgView addSubview:self.tipsLabel];
    [self.bgView addSubview:self.icon];
    self.bgView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    
}

#pragma mark 根据文字返回动态的宽度和高度
- (CGSize )getTheRealHeightAndWidthWithMessage:(NSString *)message {
    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(HUD_WIDTH - (self.tipsLabel.edgeInsets.left + self.tipsLabel.edgeInsets.right) , MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}
                                                    context:nil].size;
    CGFloat realHeight = (HUD_WIDTH  * (labelSize.height + self.tipsLabel.edgeInsets.top + self.tipsLabel.edgeInsets.bottom))/HUD_WIDTH;
    CGFloat realWidth = labelSize.width + self.tipsLabel.edgeInsets.left + self.tipsLabel.edgeInsets.right;
    CGSize size = CGSizeMake(realWidth, realHeight);
    return size;
}

#pragma mark 动画
- (void)showLoadingAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setToValue:@(M_PI * 2)];
    [animation setRepeatDuration:MAXFLOAT];
    [animation setDuration:1.0f];
    [animation setRemovedOnCompletion:NO];
    [self.icon.layer addAnimation:animation forKey:@"animationKeyOne"];
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    [view bringSubviewToFront:self];
    self.parent = view;
    CGRect frame = self.parent.frame;
    frame.origin.y = -frame.origin.y;
    self.frame = frame;
    self.layer.hidden = NO;
    self.alpha = 1.0f;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation setFromValue:@(1.0f)];//1.缩放的开始值
    [animation setToValue:@(0.97f)];//2.所要缩放到的值
    [animation setAutoreverses:YES];//3.是否原路返回
    [animation setDuration:0.618f];//4.动画时长
    [animation setRepeatDuration:MAXFLOAT];//5.动画重复次数
    [self.bgView.layer addAnimation:animation forKey:@"show"];
    [animation setRemovedOnCompletion:YES];
}

- (void)dismiss {
    [self dismissWithComplete:nil];
}

- (void)dismissWithComplete:(void (^)(void))complete {
    if (self.parent == nil) {
        if (complete != nil) {
            complete();
        }
        return;
    }
    self.parent = nil;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            if (complete != nil) {
                complete();
            }
        }
    }];
}

@end





