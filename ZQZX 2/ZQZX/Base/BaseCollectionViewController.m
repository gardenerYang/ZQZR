//
//  BaseCollectionViewController.m
//  ZQZX
//
//  Created by 中企 on 2018/10/22.
//  Copyright © 2018年 ZhangHaoHao. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "NSNotificationCenter+Util.h"

@interface BaseCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) BOOL isCanbeNoMoreData;

@end

@implementation BaseCollectionViewController


- (instancetype)init {
    self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (UICollectionViewLayout *)collectionViewLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(Iphonewidth/3, Iphonewidth/3);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return layout;
}

- (void)setupUI {
    self.layout = (UICollectionViewFlowLayout *)[self collectionViewLayout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = (id<UICollectionViewDelegate>)self;
    self.collectionView.dataSource = (id<UICollectionViewDataSource>)self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)setViewEdges:(UIEdgeInsets)edges {
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edges);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setIsCanbeNoMoreData:NO];
    [JGNotifyCenter addObserver:self selector:@selector(noMoreDataWithNotify:) name:JGTableNoMoreData object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isCanbeNoMoreData = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isCanbeNoMoreData = NO;
}

- (void)noMoreDataWithNotify:(NSNotification *)nofity {
    if (self.isCanbeNoMoreData) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - collectionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
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
