//
//  AliPayViews.m
//  AliPayDemo
//
//  Created by pg on 15/7/9.
//  Copyright (c) 2015年 pg. All rights reserved.
//

#import "AliPayViews.h"
#import "AliPayItem.h"
#import "Header.h"
#import "AlipaySubItem.h"
#import "GesturePwdHead.h"
#import "GesturePwdManageService.h"

#define KscreenHeight [UIScreen mainScreen].bounds.size.height
#define KscreenWidth [UIScreen mainScreen].bounds.size.width

#define ITEMTAG 122

@interface AliPayViews(){

    int didWrongNumber;

}
@property(nonatomic , strong)NSMutableArray *btnArray;
@property(nonatomic , assign)CGPoint movePoint;
@property(nonatomic , strong)AlipaySubItem *subItemsss;
@property(nonatomic , strong)UILabel *tfLabel;
@property(nonatomic , assign)CGPoint lastPoint;
@property (nonatomic,strong)UIButton *clearBnt;

/**
 *  背景渐变色
 */
@property (strong, nonatomic) CAGradientLayer *backgroundGradient;
@end



@implementation AliPayViews

- (NSMutableArray *)btnArray
{
    if (_btnArray==nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (UILabel *)tfLabel
{
    if (_tfLabel==nil) {
        _tfLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.subItemsss.frame.origin.y+50, KscreenWidth , 40)];
        _tfLabel.textAlignment = NSTextAlignmentCenter;
        _tfLabel.textColor = [UIColor whiteColor];
        _tfLabel.text = SETPSWSTRING;
        [self addSubview:_tfLabel];
    }
    return _tfLabel;
}

- (UIButton *)clearBnt
{
    if (_clearBnt==nil) {
        _clearBnt = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBnt.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 100,[UIScreen mainScreen].bounds.size.width, 60);
        [_clearBnt setTitle:@"重新绘制手势密码" forState:UIControlStateNormal];
//        _clearBnt.backgroundColor = [UIColor redColor];
        
        _clearBnt.hidden = YES;
        [_clearBnt addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clearBnt];
    }
    return _clearBnt;
}
// 清除手势密码
-(void)clean{


     self.tfLabel.text = SETPSWSTRING;
      self.tfLabel.textColor = [UIColor whiteColor];
    
    _clearBnt .hidden = YES;
    [GesturePwdManageService setObject:@"" forKey:KEYCHAIN_KEY];
    [GesturePwdManageService setObject:@"" forKey:TMEPWD_KEY];
}
- (AlipaySubItem *)subItemsss
{
    if (_subItemsss==nil) {
        _subItemsss = [[AlipaySubItem alloc] initWithFrame:CGRectMake((self.frame.size.width-SUBITEMTOTALWH)/2, SUBITEM_TOP, SUBITEMTOTALWH, SUBITEMTOTALWH)];
        [self addSubview:_subItemsss];
    }
    return _subItemsss;
}

-(void)setforgotBnt{

//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 64, 64);
//    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:backBtn];
    
    UIButton *fotPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    fotPwd.frame = CGRectMake(20,[UIScreen mainScreen].bounds.size.height - 100,120, 60);
    [fotPwd setTitle:@"忘记手势密码" forState:UIControlStateNormal];
    [fotPwd addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:fotPwd];
    
//    UIButton *newLogin = [UIButton buttonWithType:UIButtonTypeCustom];
//    newLogin.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-120,[UIScreen mainScreen].bounds.size.height - 100,120, 60);
//    [newLogin setTitle:@"切换用户" forState:UIControlStateNormal];
//    [newLogin addTarget:self action:@selector(changeUser) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:newLogin];
}
-(void)back{

    
    if (self.AliPayViewsBlcok)
    {
        self.AliPayViewsBlcok(forgetPwd);
    }

    //[self FailblockAction:NO];
}

-(void)changeUser
{
    if (self.AliPayViewsBlcok)
    {
        
        self.AliPayViewsBlcok(changeAccount);
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        didWrongNumber  =[[[NSUserDefaults standardUserDefaults]objectForKey:@"didWrongNumber"] intValue];
        [self initViews];
        
    }
    return self;
}

#pragma mark - init
- (void)initViews
{
//    self.backgroundColor = [RdAppSkinColor sharedInstance].auxiliaryColor;
    self.backgroundColor = [UIColor clearColor];
//    //背景渐变
//    _backgroundGradient = [CAGradientLayer layer];
//    _backgroundGradient.colors = @[(__bridge id)[UIColor colorFromHexString:@"#0064d0"].CGColor,(__bridge id)[UIColor colorFromHexString:@"#1ba8f7"].CGColor];
//    _backgroundGradient.startPoint = CGPointMake(0, 1);
//    _backgroundGradient.endPoint = CGPointMake(0, 0);
//    _backgroundGradient.frame = self.frame;
//    [self.layer addSublayer:_backgroundGradient];
    
    /*******  上面的9个小点 ******/
    self.subItemsss.backgroundColor = [UIColor clearColor];
    
    
    /***** 提示文字 ******/
    self.tfLabel.backgroundColor = [UIColor clearColor];
    
    
    /****** 9个大点的布局 *****/
    [self createPoint_nine];

    
    [self clearBnt];

    /******* 小按钮上三角的point ******/
    _lastPoint = CGPointMake(0, 0);
    
}






#pragma mark - Touch Event
/**
 *  begin
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint point = [self touchLocation:touches];
    
    [self isContainItem:point];
    
}


/**
 *  touch Move
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint point = [self touchLocation:touches];
    
    [self isContainItem:point];
    
    [self touchMove_triangleAction];
    
    [self setNeedsDisplay];

}


/**
 *  touch End
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self touchEndAction];
    
    [self setNeedsDisplay];
    

}



#pragma mark - UILabel  property
- (void)shake:(UIView *)myView
{
    int offset = 8 ;
    
    CALayer *lbl = [myView layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-offset, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+offset, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.06];
    [animation setRepeatCount:2];
    [lbl addAnimation:animation forKey:nil];
    
}





- (void)setGestureModel:(GestureModel)gestureModel
{
    _gestureModel = gestureModel;
    self.tfLabel.textColor = [UIColor whiteColor];

    switch (gestureModel) {
            
        case AlertPwdModel:
            //修改密码
            self.tfLabel.text = INPUT_OLD_PSWSTRING; //请输入原始密码
            break;
            
        case SetPwdModel:
            //重置密码
            self.tfLabel.text = SETPSWSTRING;        //请滑动设置密码
            break;
            
        case ValidatePwdModel:
        {
            //验证密码
            self.tfLabel.text = VALIDATE_PSWSTRING; //验证密码
            [self setforgotBnt];

        }
            break;
            
        case DeletePwdModel:
            //删除密码
            [GesturePwdManageService forgotPsw];
            break;
            
        default:
            break;
    }
}





#pragma mark - total method

/**
 *  下面的9个划线的点   init
 */
- (void)createPoint_nine
{
    
    for (int i=0; i<9; i++)
    {
        int row    = i / 3;
        int column = i % 3;
        
        CGFloat spaceFloat = (KscreenWidth-3*ITEMWH)/4;             //每个item的间距是等宽的
        CGFloat pointX     = spaceFloat*(column+1)+ITEMWH*column;   //起点X
        CGFloat pointY     = ITEM_TOTAL_POSITION + ITEMWH*row + spaceFloat*row;     //起点Y
        
        /**
         *  对每一个item的frame的布局
         */
        AliPayItem *item = [[AliPayItem alloc] initWithFrame:CGRectMake( pointX  , pointY , ITEMWH, ITEMWH)];
        item.userInteractionEnabled = YES;
        item.backgroundColor = [UIColor clearColor];
        item.isSelect = NO;
        item.tag = ITEMTAG + i ;
        [self addSubview:item];
        
        //NSLog(@"item.frame = [%@]", NSStringFromCGPoint(item.center));
    }
}

/**
 *  touch  begin move
 */

- (CGPoint)touchLocation:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _movePoint = point;
    
    return point;
}

- (void)isContainItem:(CGPoint)point
{
    for (AliPayItem *item  in self.subviews)
    {
        if (![item isKindOfClass:[AlipaySubItem class]] && [item isKindOfClass:[AliPayItem class]])
        {
            BOOL isContain = CGRectContainsPoint(item.frame, point);
            if (isContain && item.isSelect==NO)
            {
                [self.btnArray addObject:item];
                item.isSelect = YES;
                item.model = selectStyle;
            }
        }
        
    }
    
}

- (void)touchMove_triangleAction
{
    NSString *resultStr = [self getResultPwd];
    if (resultStr&&resultStr.length>0   )
    {
        NSArray *resultArr = [resultStr componentsSeparatedByString:@"A"];
        if ([resultArr isKindOfClass:[NSArray class]]  &&  resultArr.count>2 )
        {
            NSString *lastTag    = resultArr[resultArr.count-1];
            NSString *lastTwoTag = resultArr[resultArr.count-2];

            CGPoint lastP ;
            CGPoint lastTwoP;
            AliPayItem *lastItem;
            
            for (AliPayItem *item  in self.btnArray)
            {
                if (item.tag-ITEMTAG == lastTag.intValue)
                {
                    lastP = item.center;
                }
                if (item.tag-ITEMTAG == lastTwoTag.intValue)
                {
                    lastTwoP = item.center;
                    lastItem = item;
                }
                
                CGFloat x1 = lastTwoP.x;
                CGFloat y1 = lastTwoP.y;
                CGFloat x2 = lastP.x;
                CGFloat y2 = lastP.y;

                [lastItem judegeDirectionActionx1:x1 y1:y1 x2:x2 y2:y2 isHidden:NO];

            }
            
            
            
        }
    }
}

/**
 *  touch end
 */
- (void)touchEndAction
{
    for (AliPayItem *itemssss in self.btnArray)
    {
        [itemssss judegeDirectionActionx1:0 y1:0 x2:0 y2:0 isHidden:NO];
    }
    
    
    // if (判断格式少于4个点) [处理密码数据]
    if ([self judgeFormat]) [self setPswMethod:[self getResultPwd]] ;

    
    // 数组清空
    [self.btnArray removeAllObjects];
    
    
    // 选中样式
    for (AliPayItem *item  in self.subviews)
    {
        if (![item isKindOfClass:[AlipaySubItem class]] && [item isKindOfClass:[AliPayItem class]])
        {
            item.isSelect = NO;
            item.model = normalStyle;
            [item judegeDirectionActionx1:0 y1:0 x2:0 y2:0 isHidden:YES];
        }
        
    }
    
}



/**
 *  少于4个点
 */
- (BOOL)judgeFormat
{
    if (self.btnArray.count<=3) {
        //不合法
        self.tfLabel.textColor = LABELWRONGCOLOR;
        self.tfLabel.text      = PSW_WRONG_NUMSTRING;
        [self shake:self.tfLabel];
        return NO;
    }
    
    return YES;
}

/**
 *  对密码str进行处理
 */
- (NSString *)getResultPwd
{
    NSMutableString *resultStr = [NSMutableString string];
    
    for (AliPayItem *item  in self.btnArray)
    {
        if (![item isKindOfClass:[AlipaySubItem class]] && [item isKindOfClass:[AliPayItem class]])
        {
            [resultStr appendString:@"A"];
            [resultStr appendString:[NSString stringWithFormat:@"%ld", (long)item.tag-ITEMTAG]];
        }
    }
    
    return (NSString *)resultStr;
}




#pragma mark - 处理修改，设置，登录的业务逻辑

-(void)cleartap
{

  

}
- (void)setPswMethod:(NSString *)resultStr
{
    //没有任何记录，第一次登录
    BOOL isSaveBool = [GesturePwdManageService isFirstInput:resultStr];
    
    //默认为蓝色
   [UIColor grayColor];
    UIColor *color = SELECTCOLOR;
    
    if (isSaveBool) {
        
        //第一次输入之后，显示的文字
        _clearBnt.hidden = NO;
        self.tfLabel.text = RESETPSWSTRING;
        self.tfLabel.textColor = [UIColor whiteColor];
        
    } else {
        //密码已经存在
        //1 , 修改
        //2 , 验证
        //3 , 登录
        
        //设置密码
        color = [self setPwdJudgeAction:color str:resultStr];
        
        //修改密码
        color = [self alertPwdJudgeAction:color str:resultStr];
        
        //验证密码
        color = [self validatePwdJudgeAction:color str:resultStr];
        
    }
    
    /**************  小键盘颜色 ***************/
    [self.subItemsss resultArr:(NSArray *)[resultStr componentsSeparatedByString:@"A"] fillColor:color];
    
}



/**
 *  设置密码
 */
- (UIColor *)setPwdJudgeAction:(UIColor *)color str:(NSString *)resultStr
{
    /**
     *  设置密码
     */
    if (self.gestureModel == SetPwdModel) {
        
        // isRight == YES 2次的密码相同
        BOOL isRight = [GesturePwdManageService isSecondInputRight:resultStr];
        if (isRight) {
            // 验证成功
            [[NSUserDefaults standardUserDefaults]setObject:ERROR_COUNT forKey:@"didWrongNumber"];
            self.tfLabel.text = PSWSUCCESSSTRING;
            self.tfLabel.textColor =  [UIColor whiteColor];
            [self performSelector:@selector(blockAction:) withObject:resultStr afterDelay:.8];
            
        } else {
            
            // 失败
            self.tfLabel.text = PSWFAILTSTRING;
            self.tfLabel.textColor = LABELWRONGCOLOR;
            [self shake:self.tfLabel];
            color = LABELWRONGCOLOR;
            
        }
    }
    return color;
}
/**
 *  修改密码
 */
- (UIColor *)alertPwdJudgeAction:(UIColor *)color str:(NSString *)resultStr
{
    /**
     *  修改
     */
    if (self.gestureModel == AlertPwdModel)
    {
        BOOL isValidate = [GesturePwdManageService valideInputStr:resultStr];
        if (isValidate) {
            
            //如果验证成功
//            [AppPwdManageService forgotPsw];
            [GesturePwdManageService setObject:@"" forKey:TMEPWD_KEY];
            self.tfLabel.text = INPUT_NEW_PSWSTRING;
            self.tfLabel.textColor = [UIColor whiteColor];
            _gestureModel = SetPwdModel;
            
        } else {
            
            int number=[[[NSUserDefaults standardUserDefaults]objectForKey:@"didWrongNumber"] intValue];
              number  =number -1;
              [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",number] forKey:@"didWrongNumber"];
            if (number<=0) {
                 self.tfLabel.text =@"密码验证失败请重新登陆~~~";
                [self FailblockAction:NO];
            }else{
                //验证失败
                self.tfLabel.text = [NSString stringWithFormat:@"密码输入错误你还有%d次机会",number];
                self.tfLabel.textColor = LABELWRONGCOLOR;
                [self shake:self.tfLabel];
                color = LABELWRONGCOLOR;
            }
          
          
        }
    }
    return color;
}

/**
 *  验证，登录
 */
- (UIColor *)validatePwdJudgeAction:(UIColor *)color str:(NSString *)resultStr
{
    
    
    if (self.gestureModel == ValidatePwdModel) {
        BOOL isValidate = [GesturePwdManageService valideInputStr:resultStr];
        if (isValidate) {
            self.tfLabel.text = VALIDATE_PSWSTRING_SUCCESS;
            self.tfLabel.textColor = [UIColor whiteColor];
            [self performSelector:@selector(blockAction:) withObject:resultStr afterDelay:.8];
            
        } else {
            //失败
            int number=[[[NSUserDefaults standardUserDefaults]objectForKey:@"didWrongNumber"] intValue];
            number  =number -1;
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",number] forKey:@"didWrongNumber"];
            if (number<=0) {
                [self FailblockAction:NO];
                 self.tfLabel.text =@"密码验证失败请重新登录~~~";
                [[NSUserDefaults standardUserDefaults]setObject:ERROR_COUNT forKey:@"didWrongNumber"];
            }else {
                
                self.tfLabel.text = [NSString stringWithFormat:@"密码输入错误你还有%d次机会",number];
                // self.tfLabel.text = PSWFAILTSTRING;
                self.tfLabel.textColor = LABELWRONGCOLOR;
                [self shake:self.tfLabel];
                color = LABELWRONGCOLOR;
            }
            

        }
    }
    
    return color;
}

/**
 *   成功的block回调
 */
- (void)blockAction:(NSString *)resultStr
{
    //如果验证成功
    [GesturePwdManageService saveInputPassword:resultStr];
    [[NSUserDefaults standardUserDefaults]setObject:ERROR_COUNT forKey:@"didWrongNumber"];
    if (self.AliPayViewsBlcok) {
        self.AliPayViewsBlcok(success);
    }
//    if (self.block)
//    {
//        _gestureModel = NoneModel;
//        self.block([resultStr stringByReplacingOccurrencesOfString:@"A" withString:@"__"]);
//    }
}
/**
 *   失败的block回调
 */
- (void)FailblockAction:(BOOL)resultStr
{
    [[NSUserDefaults standardUserDefaults]setObject:ERROR_COUNT forKey:@"didWrongNumber"];
    if (self.AliPayViewsBlcok) {
        self.AliPayViewsBlcok(failedcount);
    }
}






#pragma mark - drawRect
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];

    for (int i=0; i<self.btnArray.count; i++)
    {
        AliPayItem *item = (AliPayItem *)self.btnArray[i];
        if (i==0)
        {
            [path moveToPoint:item.center];
        }
        else
        {
            [path addLineToPoint:item.center];
        }
    }
    
    if (_movePoint.x!=0 && _movePoint.y!=0 && NSStringFromCGPoint(_movePoint))
    {
        [path addLineToPoint:_movePoint];
    }
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineWidth:1.0f];
    [SELECTCOLOR setStroke];
    [path stroke];
    
    
}






@end
