//
//  WebviewViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "WebviewViewController.h"

@interface WebviewViewController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) UIProgressView    *progressView;

//@property (nonatomic, strong) JSBridge          *bridge;

@property (nonatomic, strong) NSString          *forgetUrl;
@end

@implementation WebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];

}
-(void)setupUI {
    
    [self setupNavigation];
    [self setupWKWebView];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, Iphonewidth, 2)];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    self.progressView.tintColor = [UIColor m_red];
    self.progressView.trackTintColor = [UIColor m_bgColor];
    [self.view addSubview:self.progressView];
}

- (void)setupNavigation {
    
    __weak typeof(self) wf = self;
    [self setLeftBarButtonItemWithImg:@"back" selector:^(id sender) {
        [wf goBack];
    }];
    
    
    
//    self.rightFirstBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
//    self.rightFirstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.rightFirstBtn.titleLabel.font=[UIFont systemFontOfSize:17.0];
//    [self.rightFirstBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    //    [self.rightFirstBtn setTitle:@"按钮" forState:UIControlStateNormal];
//    self.rightFirstBtn.hidden=YES;
//
//    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
//    self.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:17.0];
//    [self.rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    //    [self.rightBtn setTitle:@"按钮" forState:UIControlStateNormal];
//    self.rightBtn.hidden=YES;
//    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithCustomView:self.rightFirstBtn];
//
//    UIBarButtonItem* item2 = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
//    self.navigationItem.rightBarButtonItems = @[item2,item1];
}

- (void)setupWKWebView {
    
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    
//    wkWebConfig.userContentController = wkUController;
//    
//    //自适应屏幕的宽度js
//    
//    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    
//    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    
//    //添加js调用
//    
//    [wkUController addUserScript:wkUserScript];
    
  
    
    
    self.webView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Iphonewidth, IphoneHight - NavHeight-StatusBarHight) configuration:wkWebConfig];;
   
    self.webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.webView];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    if (_url.length == 0) {
        if (_htmlText==nil) {
            return;
        }
        [self.webView loadHTMLString:_htmlText baseURL:nil];
    }
    else
    {
    NSURLComponents *components = [NSURLComponents componentsWithString:_url];
    //创建完整url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:components.URL];
    
    [self.webView loadRequest:request];
    }
    
}

- (void)reloadWebView {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    
    [self setupWKWebView];
}

- (void)backSweepGesture:(UISwipeGestureRecognizer*)gesture {
    [self goBack];
}

-(void)goBack {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.webView.canGoBack && ![self.webView.URL.absoluteString isEqualToString:self.forgetUrl]) {
            NSLog(@"否");
            [self.webView goBack];
        }else
        {
            
         [self.navigationController popViewControllerAnimated:YES];
        }
    });
    
}

-(void)goPop {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)forget {
    self.forgetUrl = self.webView.URL.absoluteString;
    NSLog(@"%@",self.forgetUrl);
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    NSLog(@"JSWebviewViewController dealloc");
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isEqual:self.webView]) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            [self.progressView setAlpha:1];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            __weak typeof (self)weakSelf = self;
            if(self.webView.estimatedProgress == 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
                } completion:^(BOOL finished) {
                    weakSelf.progressView.hidden = YES;
                }];
            }
        }
        
        if ([keyPath isEqualToString:@"title"]) {
            [self setCustomerTitle:self.webView.title];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
