//
//  QAModel.h
//  ZQZX
//
//  Created by yangshuai on 2019/1/18.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN
@class QAQModel;
@interface QAModel : BaseClass
@property (nonatomic ,   copy) NSString*              content;
@property (nonatomic , strong) NSArray <QAQModel *>     * investAnswers;
@property (nonatomic,strong) NSNumber*  id;
@property (nonatomic,strong) NSNumber*  type;


@end

@interface QAQModel : BaseClass
@property (nonatomic,  copy) NSString * content;
@property (nonatomic,  copy) NSString * option;
@property (nonatomic,  copy) NSString * q_code;
@property (nonatomic,strong) NSNumber*  score;
@property (nonatomic,  copy) NSString * clientType;
@property (nonatomic,  copy) NSString * productType;
@property (nonatomic,  copy) NSString * tips;

@end
NS_ASSUME_NONNULL_END
