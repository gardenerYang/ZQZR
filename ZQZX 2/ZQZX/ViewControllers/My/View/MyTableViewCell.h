//
//  MyTableViewCell.h
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, cellType) {
    cellTypeDefault,
    cellTypeImg,
};
NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView   *headImg;
@property (nonatomic, strong) UIImageView   *arrowImg;

@property (nonatomic, strong) UILabel   * titleLb;
@property (nonatomic, strong) UILabel   * srcLb;
@property (nonatomic, assign) cellType  type;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(cellType)type;
-(void)updateLB;
@end

NS_ASSUME_NONNULL_END
