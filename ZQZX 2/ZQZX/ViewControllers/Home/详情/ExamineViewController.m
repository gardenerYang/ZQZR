//
//  ExamineViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/27.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "ExamineViewController.h"
#import "ExamineCollectionViewCell.h"

@interface ExamineViewController ()
@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation ExamineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr=@[@{@"title":@"人工专业验票",@"src":@"已通过"},
               @{@"title":@"持票企业经营资质审核",@"src":@"已通过"},
               @{@"title":@"开票企业资质审核",@"src":@"已通过"},
               @{@"title":@"开票企业票据兑付审核",@"src":@"已通过"},
              ];
    [self.collectionView registerClass:[ExamineCollectionViewCell class]];
    
}
- (UICollectionViewLayout *)collectionViewLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(Iphonewidth/2, 100);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    layout.headerReferenceSize = CGSizeMake(Iphonewidth, 20);
    //    layout.sectionInset = UIEdgeInsetsMake(0, 10, 30, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return layout;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExamineCollectionViewCell *cell = [collectionView dequeueReusableClass:[ExamineCollectionViewCell class] forIndexPath:indexPath];
    cell.titleLB.text = _dataArr[indexPath.row][@"title"];
    cell.stateLB.text = _dataArr[indexPath.row][@"src"];
    //    NSLog(@"%@",_imgArr[indexPath.row]);
    return cell;
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
