//
//  ProjectTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel      *titleLb;
@property (nonatomic, strong) UILabel      *srcLb;
@property (nonatomic, strong) UIImageView      *imageV;
@property (nonatomic, assign) BOOL      isShowImage;

@end

NS_ASSUME_NONNULL_END
