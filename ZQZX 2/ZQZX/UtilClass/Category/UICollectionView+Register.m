//
//  UICollectionView+Register.m
//  Ninesecretary
//
//  Created by JG on 2017/10/25.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "UICollectionView+Register.h"
#import "NoDataView.h"
@interface UICollectionView ()
@property (nonatomic, strong) NoDataView *noView;
@end

@implementation UICollectionView (Register)

static const void *refreshingKey = &refreshingKey;
static const void *noViewKey = &noViewKey;

//TODO: set
- (void)setNoView:(NoDataView *)noView {
    objc_setAssociatedObject(self, noViewKey, noView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NoDataView *)noView {
    return objc_getAssociatedObject(self, noViewKey);
}

- (void)setRefreshing:(BOOL)refreshing {
    objc_setAssociatedObject(self, refreshingKey, @(refreshing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)refreshing {
    NSNumber *refresh = objc_getAssociatedObject(self, refreshingKey);
    
    if (refresh == nil) {
        refresh = @NO;
        self.refreshing = refresh.boolValue;
    }
    
    return refresh.boolValue;
}
//TODO: 注册
- (void)registerClass:(Class)cellClass {
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (id)dequeueReusableClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (void)registerHeader:(Class)classes {
    [self registerClass:classes forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(classes)];
}
- (id)dequeueReusableHeader:(Class)headerClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(headerClass) forIndexPath:indexPath];
}

- (void)registerFooter:(Class)classes {
    [self registerClass:classes forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(classes)];
}

- (id)dequeueReusableFooter:(Class)footerClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(footerClass) forIndexPath:indexPath];
}

//TODO: 刷新
- (void)addMJ_Header:(void (^)(void))begin {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (begin) {
            begin();
        }
    }];
}

- (void)addMJ_Footer:(void (^)(void))begin {
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (begin) {
            begin();
        }
    }];
    [self.mj_footer setAutomaticallyHidden:YES];
}

- (void)refresh {
    if (self.mj_header == nil || (self.mj_header != nil && self.mj_header.isRefreshing)) {
        return;
    }
    
    if (self.mj_footer != nil && self.mj_footer.isRefreshing) {
        return;
    }
    [self.mj_header beginRefreshing];
}

- (void)loadMore {
    if (self.mj_footer == nil || (self.mj_footer != nil && self.mj_footer.isRefreshing)) {
        return;
    }
    
    if (self.mj_header != nil && self.mj_header.isRefreshing) {
        return;
    }
    [self.mj_footer beginRefreshing];
}

- (void)stopReload {
    if (self.mj_header != nil && self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    
    if (self.mj_footer != nil && self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
}

- (void)noMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetMoreData {
    [self.mj_footer resetNoMoreData];
}

- (void)addNoDataView:(NSString *)title {
    if (self.noView == nil) {
        self.noView = [[NoDataView alloc] initWithType:NoDataTypeDefault];
    }
    self.noView.hidden = NO;
    self.noView.imgView.image = [UIImage imageNamed:@"NodataImage"];
    self.noView.imgView.userInteractionEnabled = NO;
    self.noView.titleLb.text = title;
    self.noView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.backgroundView = self.noView;
}

- (void)removeNoDataView {
    self.noView = nil;
    self.backgroundView = nil;
}

@end
