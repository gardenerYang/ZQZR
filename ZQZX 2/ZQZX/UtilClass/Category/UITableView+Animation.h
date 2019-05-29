//
//  UITableView+Animation.h
//  Ninesecretary
//
//  Created by JG on 2017/11/24.
//  Copyright © 2017年 张豪. All rights reserved.
//

typedef NS_ENUM(NSInteger, TableViewAnimationType){
    TableViewAnimationTypeNone = -1,
    TableViewAnimationTypeMove = 0,
    TableViewAnimationTypeMoveSpring,
    TableViewAnimationTypeAlpha,
    TableViewAnimationTypeFall,
    TableViewAnimationTypeShake,
    TableViewAnimationTypeOverturn,
    TableViewAnimationTypeToTop,
    TableViewAnimationTypeSpringList,
    TableViewAnimationTypeShrinkToTop,
    TableViewAnimationTypeLayDown,
    TableViewAnimationTypeRote = 10,
};

@interface UITableView (Animation)

@property (nonatomic, assign) TableViewAnimationType animationType;

- (void)showAnimationWithType:(TableViewAnimationType)type;

@end
