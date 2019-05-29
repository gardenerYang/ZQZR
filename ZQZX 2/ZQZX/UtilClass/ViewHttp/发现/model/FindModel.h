//
//  FindModel.h
//  ZQZX
//
//  Created by 中企 on 2018/10/25.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseClass.h"

@class  ListItem;
NS_ASSUME_NONNULL_BEGIN

@interface FindModel : BaseClass
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , strong) NSString              * bannerUrl;
@property (nonatomic , strong) NSArray <ListItem *>              * cList;
@property (nonatomic , assign) NSInteger              pageNum;
@property (nonatomic , strong) NSString              * content;
@property (nonatomic , strong) NSString              * url;

@end

@interface ListItem :BaseClass
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * introduction;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , assign) NSInteger              publishTime;
@property (nonatomic , assign) NSInteger              isDisplay;
@property (nonatomic , assign) NSInteger              isTop;
@property (nonatomic , copy) NSString              * subTitle;
@property (nonatomic , copy) NSString              * source;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * urlHref;
@end
NS_ASSUME_NONNULL_END
