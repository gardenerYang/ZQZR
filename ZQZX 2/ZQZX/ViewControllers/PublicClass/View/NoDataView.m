//
//  NoDataView.m
//  Ninesecretary
//
//  Created by chenglian on 2017/7/4.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "NoDataView.h"
#import "UIImage+Util.h" 
@interface NoDataView () {
    NoDataType _type;
}

@end

@implementation NoDataView

- (instancetype)initWithType:(NoDataType)type {
    self = [super init];
    
    if (self) {
        _type = type;
        [self initUI];
    }
    
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor withHexStr:@"#f4f0ef"];
    
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imgWithColor:[UIColor m_gray] frame:CGRectMake(0, 0, 150, 150)]];
    [self addSubview:_imgView];
    _imgView.contentMode =UIViewContentModeScaleAspectFit;
    
    _titleLb = [[UILabel alloc] init];
    _titleLb.font = [UIFont s14];
    _titleLb.textColor = kLightGray;
    [self addSubview:_titleLb];
    
    if (_type == NoDataTypeSelected) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitleColor:kMainColor forState:UIControlStateNormal];
        [_detailBtn.titleLabel setFont:[UIFont s14]];
        [_detailBtn addTarget:self action:@selector(toEnter:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_detailBtn];
        
        [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLb.mas_bottom).mas_offset(1.5);
            make.centerX.mas_equalTo(0);
        }];
    }
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@200);
        make.centerX.mas_equalTo(0);
        make.left.mas_greaterThanOrEqualTo(10);
        make.right.mas_lessThanOrEqualTo(-10);
    }];
    
    CGSize size = CGSizeMake(165.f * Iphonewidth / 750.f, 165.f * Iphonewidth / 750.f);
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLb.mas_top).offset(-20);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(165, 165));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toReload:)];
    [self addGestureRecognizer:tap];
}

- (IBAction)toEnter:(id)sender {
    
    if (_toEnter) {
        _toEnter();
    }
}

- (IBAction)toReload:(id)sender {
    if (_reloadData) {
        _reloadData();
    }
}

@end
