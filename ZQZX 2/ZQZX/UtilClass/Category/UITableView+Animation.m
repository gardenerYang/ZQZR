//
//  UITableView+Animation.m
//  Ninesecretary
//
//  Created by JG on 2017/11/24.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "UITableView+Animation.h"
#import <objc/runtime.h>

@implementation UITableView (Animation)

static char *AnimationTypeKey = "AnimationTypeKey";

- (void)setAnimationType:(TableViewAnimationType)animationType {
    objc_setAssociatedObject(self, AnimationTypeKey, @(animationType), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TableViewAnimationType)animationType {
    NSNumber *typeNum = objc_getAssociatedObject(self, AnimationTypeKey);
    
    if (typeNum == nil) {
        typeNum = @(TableViewAnimationTypeNone);
    }
    return typeNum.integerValue;
}

+ (void)load {
    Method originalM = class_getInstanceMethod([self class], @selector(reloadData));
    Method exchangeM = class_getInstanceMethod([self class], @selector(_reloadData));
    method_exchangeImplementations(originalM, exchangeM);
}

- (void)_reloadData {
    [self _reloadData];
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    if (cells.count > 0) {
        [self performSelector:@selector(_showAnimationWithType:) withObject:@(self.animationType) afterDelay:0];
    }
}

- (void)showAnimationWithType:(TableViewAnimationType)type {
    [self _showAnimationWithType:@(type)];
}

- (void)_showAnimationWithType:(NSNumber *)typeNum {
    TableViewAnimationType type = typeNum.integerValue;
    
    switch (type) {
        case TableViewAnimationTypeMove:
            [self moveAnimation];
            break;
        case TableViewAnimationTypeMoveSpring:
            [self moveSpringAnimation];
            break;
        case TableViewAnimationTypeAlpha:
            [self alphaAnimation];
            break;
        case TableViewAnimationTypeFall:
            [self fallAnimation];
            break;
        case TableViewAnimationTypeShake:
            [self shakeAnimation];
            break;
        case  TableViewAnimationTypeOverturn:
            [self overturnAnimation];
            break;
        case TableViewAnimationTypeToTop:
            [self toTopAnimation];
            break;
        case TableViewAnimationTypeSpringList:
            [self springListAnimation];
            break;
        case TableViewAnimationTypeShrinkToTop:
            [self shrinkToTopAnimation];
            break;
        case TableViewAnimationTypeLayDown:
            [self layDownAnimation];
            break;
        case TableViewAnimationTypeRote:
            [self roteAnimation];
            break;
        default:
            break;
    }
}

- (void)moveAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.transform = CGAffineTransformMakeTranslation(- Iphonewidth, 0);
        [UIView animateWithDuration:0.25 delay:idx * (0.3 / cells.count) options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)moveSpringAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.transform = CGAffineTransformMakeTranslation(- Iphonewidth, 0);
        [UIView animateWithDuration:0.4 delay:idx * (0.4 / cells.count) usingSpringWithDamping:0.7 initialSpringVelocity:1 / 0.7 options:UIViewAnimationOptionCurveEaseIn animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

- (void)alphaAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.alpha = 0;
        [UIView animateWithDuration:0.4 delay:idx * 0.05 options:0 animations:^{
            cell.alpha = 1;
        } completion:nil];
    }];
}

- (void)fallAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.transform = CGAffineTransformMakeTranslation(0, - IphoneHight);
        [UIView animateWithDuration:0.4 delay:idx * 0.05 options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

- (void)shakeAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx % 2 == 0) {
            cell.transform = CGAffineTransformMakeTranslation(- Iphonewidth, 0);
        } else {
            cell.transform = CGAffineTransformMakeTranslation(Iphonewidth, 0);
        }
        [UIView animateWithDuration:0.4 delay:idx * 0.03 usingSpringWithDamping:0.75 initialSpringVelocity:1/0.75 options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

- (void)overturnAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.layer.opacity = 0;
        cell.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        [UIView animateWithDuration:0.3 delay:idx * (0.7 / cells.count) options:0 animations:^{
            cell.layer.opacity = 1;
            cell.layer.transform = CATransform3DIdentity;
        } completion:nil];
    }];
}

- (void)toTopAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.transform = CGAffineTransformMakeTranslation(- Iphonewidth, 0);
        [UIView animateWithDuration:0.35 delay:idx * (0.8 / cells.count) options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)springListAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.layer.opacity = 0.7;
        cell.layer.transform = CATransform3DMakeTranslation(0, - IphoneHight, 20);
        
        [UIView animateWithDuration:0.4 delay:idx * (1.0 / cells.count) usingSpringWithDamping:0.65 initialSpringVelocity:1/0.65 options:0 animations:^{
            cell.layer.opacity = 1.0;
            cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20);
        } completion:nil];
    }];
}

- (void)shrinkToTopAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = [cell convertRect:cell.bounds fromView:self];
        cell.transform = CGAffineTransformMakeTranslation(0, -rect.origin.y);
        [UIView animateWithDuration:0.5 animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)layDownAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    NSMutableArray <NSValue *>*rectArr = [@[] mutableCopy];
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = cell.frame;
        [rectArr addObject:[NSValue valueWithCGRect:rect]];
        rect.origin.y = idx * 10;
        cell.frame = rect;
        cell.layer.transform = CATransform3DMakeTranslation(0, 0, idx * 5);
    }];
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = [[rectArr objectAtIndex:idx] CGRectValue];
        [UIView animateWithDuration:(0.8 / cells.count) * idx animations:^{
            cell.frame = rect;
        } completion:^(BOOL finished) {
            cell.layer.transform = CATransform3DIdentity;
        }];
    }];
}

- (void)roteAnimation  {
    NSArray <UITableViewCell *>*cells = self.visibleCells;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = @(-M_PI);
    animation.toValue = 0;
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.repeatCount = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.alpha = 0.0;
        
        [UIView animateWithDuration:0.1 delay:idx * 0.25 options:0 animations:^{
            cell.alpha = 1;
        } completion:^(BOOL finished) {
            [cell.layer addAnimation:animation forKey:@"rotationYkey"];
        }];
    }];
}



@end
