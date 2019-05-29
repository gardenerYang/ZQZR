//
//  detailWebviewCell.m
//  ZQZX
//
//  Created by yangshuai on 2019/2/28.
//  Copyright © 2019年 ZhangHaoHao. All rights reserved.
//

#import "detailWebviewCell.h"

@implementation detailWebviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI{
    UILabel * label = [[UILabel alloc]init];
    [self addSubview:label];
    label.textColor = [UIColor whiteColor];
    self.label = label;
    label.numberOfLines = 0;
    [self.label  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(10, 10, kWidth, 200)];
    self.webview.scrollView.scrollEnabled = NO;
    [self addSubview:self.webview];
//    [self.webview setScalesPageToFit:YES];
    self.webview.delegate = self;
    [self.webview  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    self.webview.hidden = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 获取webView的高度
    self.webview.hidden = NO;
    CGFloat webViewHeight = [[self.webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    [self.webview setHeight:webViewHeight];
    [self.webview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(webViewHeight);
    }];
    if (self.webviewLoadDidFinish) {
        self.webviewLoadDidFinish();
    }
}
@end
