//
//  BBGridLayout.h
//  BestBite Host
//
//  Created by specktro on 05/06/13.
//  Copyright (c) 2013 ironbit. All rights reserved.
//

@protocol BBGridLayoutDelegate <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl numberOfRowsInSection:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl sizeForItemWithHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl itemInsetsForSectionAtIndex:(NSInteger)section;

@end

@interface BBGridLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat headerWidth;

@end
