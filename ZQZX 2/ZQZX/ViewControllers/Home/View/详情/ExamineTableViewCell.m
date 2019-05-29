//
//  ExamineTableViewCell.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ExamineTableViewCell.h"
#import "ExamineCollectionViewCell.h"
@implementation ExamineTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _dataArr=@[@{@"title":@"人工专业验票",@"src":@"已通过"},
                   @{@"title":@"持票企业经营资质审核",@"src":@"已通过"},
                   @{@"title":@"开票企业资质审核",@"src":@"已通过"},
                   @{@"title":@"开票企业票据兑付审核",@"src":@"已通过"},
                   ];
        [self addUI];
    }
    return self;
}

-(void)addUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(Iphonewidth/2, 100);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    layout.headerReferenceSize = CGSizeMake(Iphonewidth, 20);
    //    layout.sectionInset = UIEdgeInsetsMake(0, 10, 30, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)
                                         collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    
    [self.contentView addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:NSClassFromString(@"ExamineCollectionViewCell")
        forCellWithReuseIdentifier:@"ExamineCollectionViewCell"];
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(Iphonewidth);
        make.height.mas_equalTo(200);
        make.bottom.mas_equalTo(-8);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExamineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExamineCollectionViewCell"forIndexPath:indexPath];
    
    cell.titleLB.text = _dataArr[indexPath.row][@"title"];
    cell.stateLB.text = _dataArr[indexPath.row][@"src"];
    return cell;
}
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath
{
    NSLog(@"点击了第%ld个",(long)indexPath.item);
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
