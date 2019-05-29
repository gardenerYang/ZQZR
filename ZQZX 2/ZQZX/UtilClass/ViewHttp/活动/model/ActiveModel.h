//
//  ActiveModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/26.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActiveModel : BaseClass
@property (nonatomic , copy) NSString              * numberDay;
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , copy) NSString              * activityStatus;
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * introduction;
@end

NS_ASSUME_NONNULL_END
