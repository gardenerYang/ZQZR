//
//  WebviewViewController.h
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ZHViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebviewViewController : ZHViewController
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *htmlText;
@property (nonatomic, strong) WKWebView         *webView;

@end

NS_ASSUME_NONNULL_END
