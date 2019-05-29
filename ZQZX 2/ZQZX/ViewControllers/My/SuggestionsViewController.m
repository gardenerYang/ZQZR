//
//  SuggestionsViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/19.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "SuggestionsViewController.h"
#import "WSTextView.h"
#import "HttpRequest+my.h"
@interface SuggestionsViewController ()<UITextViewDelegate>
@property (nonatomic,strong) WSTextView *textView;

@end

@implementation SuggestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor m_bgColor];
    [self setCustomerTitle:@"意见反馈"];
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"请输入您的意见或建议";
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.textColor = [UIColor m_textDeepGrayColor];
    [self.view addSubview:titleLb];
    [self.view addSubview:self.textView];
    
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitBtn setBackgroundColor:[UIColor m_red]];
    [quitBtn setTitle:@"提交" forState:UIControlStateNormal];
    quitBtn.layer.masksToBounds = YES;
    quitBtn.layer.cornerRadius = 30;
    __weak typeof(self) wf = self;
    [quitBtn addAction:^(UIButton *sender) {
        if (wf.textView.text.length <= 0) {
            [MBProgressHUD showErrorMessage:@"请输入您的宝贵意见"];
            return;
        }
        [MBProgressHUD showActivityMessageInView:@"提交中..."];

        [HttpRequest suggestionsoOpinion:wf.textView.text Requestsuccess:^(HttpResponse * _Nonnull data, NSString * _Nonnull message) {
            [MBProgressHUD showSuccessMessage:@"你的意见提交成功,我们将尽快处理"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD showErrorMessage:error.localizedDescription];

        }];
    }];
    [self.view addSubview:quitBtn];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLb.mas_bottom).offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(200);
    }];
    [quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(-40);
    }];
}
- (WSTextView*)textView {
    if (!_textView) {
        _textView = [[WSTextView alloc] init];//初始化
        _textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
        _textView.font = [UIFont s14];//设置字体名字和字体大小
        _textView.delegate = self;//设置它的委托方法
        _textView.backgroundColor=[UIColor whiteColor];
        [_textView setPlaceholder:@"请至少输入10个字以上"];
        _textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        _textView.scrollEnabled = YES;//是否可以拖动
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderColor = [UIColor m_lineColor].CGColor;
        _textView.layer.borderWidth = 1;
    }
    return _textView;
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
