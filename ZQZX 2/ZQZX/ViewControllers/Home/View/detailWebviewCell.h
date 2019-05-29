//
//  detailWebviewCell.h
//  ZQZX
//
//  Created by yangshuai on 2019/2/28.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface detailWebviewCell : UITableViewCell<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webview;
@property(nonatomic,strong)UILabel * label;
@property (nonatomic,strong) void (^ webviewLoadDidFinish)(void);
@end

NS_ASSUME_NONNULL_END
