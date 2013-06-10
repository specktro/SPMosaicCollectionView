//
//  SPGridLayoutSection.h
//  SPMosaicCollectionView
//
//  Created by specktro on 05/06/13.
//  Copyright (c) 2013 nonull. All rights reserved.
//

@interface SPGridLayoutSection : NSObject

@property (nonatomic, assign, readonly) CGRect frame;
@property (nonatomic, assign, readonly) UIEdgeInsets itemInsets;
@property (nonatomic, assign, readonly) CGFloat rowHeigth;
@property (nonatomic, assign, readonly) NSInteger numberOfItems;

- (id)initWithOrigin:(CGPoint)origin heigth:(CGFloat)heigth rows:(NSInteger)rows itemInsets:(UIEdgeInsets)itemInsets;
- (void)addItemOfSize:(CGSize)size forIndex:(NSInteger)index;
- (CGRect)frameForItemAtIndex:(NSInteger)index;

@end
