//
//  StretchingFlowLayout.m
//  Ninesecretary
//
//  Created by JG on 2017/8/28.
//  Copyright © 2017年 张豪. All rights reserved.
//

#import "StretchingFlowLayout.h"

@implementation StretchingFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    UICollectionView *collectionView = [self collectionView];
    UIEdgeInsets insets = [collectionView contentInset];
    CGPoint offset = [collectionView contentOffset];
    CGFloat minY = -insets.top;
    
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    if (offset.y < minY) {
        
        CGSize  headerSize = [self headerReferenceSize];
        CGFloat deltaY = -offset.y + minY;//fabs(offset.y - minY);
        
        for (UICollectionViewLayoutAttributes *attrs in attributes) {
            
            if ([attrs representedElementKind] == UICollectionElementKindSectionHeader) {
                
                CGRect headerRect = [attrs frame];
                headerRect.size.height = MAX(minY, headerSize.height + deltaY);
                headerRect.origin.y = headerRect.origin.y - deltaY;
                [attrs setFrame:headerRect];
                break;
            }
        }
    }
    
    return attributes;
}

@end
