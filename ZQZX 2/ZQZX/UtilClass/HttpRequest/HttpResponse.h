//
//  HttpResponse.h
//  ZQZX
//
//  Created by 中企 on 2018/10/18.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseClass.h"

typedef NS_ENUM(NSUInteger, ResponseStatus) {
    ResponseStatusSuccess = 200,//请求成功
    ResponseStatusFail = 500,//请求失败
    ResponseStatusUSERNAME_ERROR = 10000,//用户名或者密码错误
    ResponseStatusPARAM_ERROR = 10001,//参数错误
    ResponseStatusPARAM_NULL = 10002,//参数不能为空
    ResponseStatusTOKEN_ERROR = 10003,//无权限访问
    ResponseStatusVAILDCODE_ERROR = 10004,//验证码错误
    ResponseStatusREFERRAL_ERROR = 10005 //不存在此理财师推荐码"
};

NS_ASSUME_NONNULL_BEGIN

@interface HttpResponse : NSObject
@property (nonatomic, strong) NSString  *code;
@property (nonatomic, strong) NSString  *message;
@property (nonatomic, strong) id        data;
@property (nonatomic, copy) NSString * ext;
@property (nonatomic, strong) NSString  *attach;

@end

NS_ASSUME_NONNULL_END
//MARK:若后期增加外部字段,在此添加
@interface HttpResponse ()
@property (nonatomic, strong) NSString  *result;
@end

//MARK: -
@interface HttpListResponse : NSObject
@property (nonatomic, strong) NSString  *code;
@property (nonatomic, strong) NSString  *message;
@property (nonatomic, strong) NSString  *count;
@property (nonatomic, strong) NSString  *pageNum;
@property (nonatomic, strong) NSString  *pageSize;
@property (nonatomic, strong) id        data;
@property (nonatomic, strong) NSString  *ext;
@property (nonatomic, strong) NSString  *attach;
@property (nonatomic, readonly, getter=isFinish) bool      finish;

@end
//MARK: - 若后期增加外部字段,在此添加
@interface HttpListResponse ()
@property (nonatomic, strong) id        otherData;

@end


