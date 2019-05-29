//
//  HomeButtonTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/15.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "HomeButtonTableViewCell.h"
#import "UIButton+SSEdgeInsets.h"
@implementation HomeButtonTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
     return self;
}
-(void)addUI{
    self.BKView=[[UIView alloc]init];
    self.BKView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.BKView];

    [_BKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
  
    
}
-(void)setBtnTitle:(NSArray *)title selectImgArr:(NSArray *)selectArr imgArr:(NSArray *)imgArr color:(UIColor *)color
{
    __weak typeof(self) wf = self;
    for (int i = 0; i<4 ;i++) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:title[i] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:selectArr[i]] forState:UIControlStateSelected];
        
        [_btn setImagePositionWithType:SSImagePositionTypeTop spacing:5];
        [_btn setTitleColor:color forState:UIControlStateNormal];
        
        _btn.titleLabel.font = [UIFont s14];
        [_btn addAction:^(UIButton *sender) {
            if (wf.btnClickBlock) {
                wf.btnClickBlock(i);
            }
        }];
        [_BKView addSubview:_btn];
        
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(i*(Iphonewidth/4));
            make.size.mas_equalTo(CGSizeMake(Iphonewidth/4, Iphonewidth/4));
            make.bottom.mas_equalTo(-10);
        }];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
