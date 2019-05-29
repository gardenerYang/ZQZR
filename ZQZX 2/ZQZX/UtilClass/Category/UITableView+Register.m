//
//  UITableView+Register.m
//  Ninesecretary
//
//  Created by JG on 2017/10/26.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "UITableView+Register.h"


@implementation UITableView (Register)

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

- (void)registerClass:(Class)cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (id)dequeueReusableCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (void)registerHeader:(Class)classes {
    [self registerClass:classes forHeaderFooterViewReuseIdentifier:NSStringFromClass(classes)];
}
- (id)dequeueReusableHeader:(Class)headerClass {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerClass)];
}

- (void)registerFooter:(Class)classes {
    [self registerClass:classes forHeaderFooterViewReuseIdentifier:NSStringFromClass(classes)];
}

- (id)dequeueReusableFooter:(Class)footerClass {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(footerClass)];
}

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

- (void)addNoDataView:(NSString *)title image:(NSString *)image {
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


- (void)addNoDataView:(NSString *)title {
    [self addNoDataView:title image:@"NodataImage"];
}

- (void)addNoDataDetailNews {
    [self addNoDataView:@"暂时还没有消息哦～" image:@"NomessageImage"];
}

- (void)addNodata {
    [self addNoDataView:@"暂时还没有任何数据哦～" image:@"NodataImage"];
}

- (void)addNoDataDetailShopping {
    [self addNoDataView:@"暂时还没有任何数据哦～" image:@"NodataImage"];
}

- (void)removeNoDataView {
    self.noView = nil;
    self.backgroundView = nil;
}

@end
