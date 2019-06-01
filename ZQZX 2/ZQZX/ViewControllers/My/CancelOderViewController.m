//
//  CancelOderViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/20.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "CancelOderViewController.h"
#import "WSTextView.h"

@interface CancelOderViewController ()<UITextViewDelegate>
@property (nonatomic,strong) WSTextView *textView;

@end

@implementation CancelOderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomerTitle:@"取消订单"];
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"您确定取消订单吗?\n请填写取消订单的原因";
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.textColor = [UIColor m_textDeepGrayColor];
    titleLb.numberOfLines = 2;
    [self.view addSubview:titleLb];
    [self.view addSubview:self.textView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundColor:kMainColor];
    [cancelBtn setTitle:@"提交" forState:UIControlStateNormal];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 30;
    __weak typeof(self) wf = self;
    [cancelBtn addAction:^(UIButton *sender) {
        
    }];
    [self.view addSubview:cancelBtn];
    
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
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(-40);
    }];
}
- (WSTextView*)textView {
    if (!_textView) {
        _textView = [[WSTextView alloc] init];//初始化
        _textView.textColor = kTitleColor;//设置textview里面的字体颜色
        _textView.font = [UIFont s14];//设置字体名字和字体大小
        _textView.delegate = self;//设置它的委托方法
        _textView.backgroundColor=[UIColor whiteColor];
        [_textView setPlaceholder:@"请填写取消订单的原因"];
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
