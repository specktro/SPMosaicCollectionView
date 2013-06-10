//  SPGridLayout.m
//
//  Copyright (c) 2013 specktro and nonull
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "SPGridLayout.h"
#import "SPGridLayoutSection.h"

@interface SPGridLayout () {
    __weak id       <SPGridLayoutDelegate> _myDelegate;
    NSMutableArray  *_sectionData;
    CGFloat         _width;
}

@end

@implementation SPGridLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    _myDelegate = (id <SPGridLayoutDelegate>)self.collectionView.delegate;
    _sectionData = [[NSMutableArray alloc] init];
    _width = 0.0f;
    
    CGPoint currentOrigin = CGPointZero;
    NSInteger numberOfSections = self.collectionView.numberOfSections;
    
    for (NSInteger i = 0; i < numberOfSections; i++) {
        _width += self.headerWidth;
        currentOrigin.x = _width;
        
        NSInteger numberOfRows = [_myDelegate collectionView:self.collectionView
                                                      layout:self
                                       numberOfRowsInSection:i];
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:i];
        UIEdgeInsets itemInsets = [_myDelegate collectionView:self.collectionView
                                                       layout:self
                                  itemInsetsForSectionAtIndex:i];
        
        SPGridLayoutSection *section = [[SPGridLayoutSection alloc] initWithOrigin:currentOrigin
                                                                            heigth:self.collectionView.bounds.size.height
                                                                              rows:numberOfRows
                                                                        itemInsets:itemInsets];
        
        for (NSInteger j = 0; j < numberOfItems; j++) {
            CGFloat itemHeight = (section.rowHeigth - section.itemInsets.top - section.itemInsets.bottom);
            NSIndexPath *itemIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
            CGSize itemSize = [_myDelegate collectionView:self.collectionView
                                                   layout:self
                                    sizeForItemWithHeight:itemHeight
                                              atIndexPath:itemIndexPath];
            [section addItemOfSize:itemSize forIndex:j];
        }
        
        [_sectionData addObject:section];
        _width += section.frame.size.width;
        currentOrigin.x = _width;
    }
}

- (CGSize)collectionViewContentSize {
    CGSize contentSize = CGSizeMake(_width, self.collectionView.bounds.size.height);
    return contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPGridLayoutSection *section = _sectionData[indexPath.section];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect itemFrame = [section frameForItemAtIndex:indexPath.item];
    attributes.frame = itemFrame;
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SPGridLayoutSection *section = _sectionData[indexPath.section];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind
                                                                                                                  withIndexPath:indexPath];
    CGRect sectionFrame = section.frame;
    CGRect headerFrame = CGRectMake(sectionFrame.origin.x - self.headerWidth, 0.0f, self.headerWidth, sectionFrame.size.height);
    attributes.frame = headerFrame;
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    [_sectionData enumerateObjectsUsingBlock:^(SPGridLayoutSection *section, NSUInteger sectionIndex, BOOL *stop) {
        CGRect sectionFrame = section.frame;
        CGRect headerFrame = CGRectMake(sectionFrame.origin.x - self.headerWidth, 0.0f, self.headerWidth, sectionFrame.size.height);
        
        if (CGRectIntersectsRect(headerFrame, rect)) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
            UICollectionViewLayoutAttributes *la = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                        atIndexPath:indexPath];
            [attributes addObject:la];
        }
        
        if (CGRectIntersectsRect(sectionFrame, rect)) {
            for (NSInteger index = 0; index < section.numberOfItems; index++) {
                CGRect frame = [section frameForItemAtIndex:index];
                
                if (CGRectIntersectsRect(frame, rect)) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:sectionIndex];
                    UICollectionViewLayoutAttributes *la = [self layoutAttributesForItemAtIndexPath:indexPath];
                    [attributes addObject:la];
                }
            }
        }
    }];
    
    return attributes;
}

@end