//
//  ImgModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImgModel : BaseClass
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSNumber *publishTime;
@property (nonatomic, strong) NSNumber *isDisplay;
@property (nonatomic, strong) NSString *redirectUrl;
@property (nonatomic, assign) BOOL hasContent;
@property (nonatomic, strong) NSNumber *addTime;
@property (nonatomic, strong) NSString *addOperator;
@property (nonatomic, strong) NSString *addIp;
@property (nonatomic, strong) NSNumber *updateTime;
@property (nonatomic, strong) NSString *updateOperator;
@property (nonatomic, strong) NSString *updateIp;
@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
