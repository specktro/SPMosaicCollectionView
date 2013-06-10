//
//  SPGridLayoutSection.m
//  SPMosaicCollectionView
//
//  Created by specktro on 05/06/13.
//  Copyright (c) 2013 nonull. All rights reserved.
//

#import "SPGridLayoutSection.h"

@interface SPGridLayoutSection () {
    CGRect                  _frame;
    UIEdgeInsets            _itemInsets;
    CGFloat                 _rowHeigth;
    NSMutableArray          *_rowWidths;
    NSMutableDictionary     *_indexToFrameMap;
}

@end

@implementation SPGridLayoutSection

- (id)initWithOrigin:(CGPoint)origin heigth:(CGFloat)heigth rows:(NSInteger)rows itemInsets:(UIEdgeInsets)itemInsets {
    if ((self = [super init])) {
        _frame = CGRectMake(origin.x, origin.y, 0.0f, heigth);
        _itemInsets = itemInsets;
        _rowHeigth = floorf(heigth / rows);
        _rowWidths = [[NSMutableArray alloc] init];
        _indexToFrameMap = [[NSMutableDictionary alloc] init];
        
        for (NSInteger i = 0; i < rows; i++)
            [_rowWidths addObject:@(0.0f)];
    }
    
    return self;
}

- (CGRect)frame {
    return _frame;
}

- (CGFloat)rowHeigth {
    return _rowHeigth;
}

- (NSInteger)numberOfItems {
    return _indexToFrameMap.count;
}

- (void)addItemOfSize:(CGSize)size forIndex:(NSInteger)index {
    // 1
    __block CGFloat shortestRowWidth = CGFLOAT_MAX;
    __block NSUInteger shortestRowIndex = 0;
    
    // 2
    [_rowWidths enumerateObjectsUsingBlock:^(NSNumber *width, NSUInteger idx, BOOL *stop) {
        CGFloat thisRowWidth = [width floatValue];
        
        if (thisRowWidth < shortestRowWidth) {
            shortestRowWidth = thisRowWidth;
            shortestRowIndex = idx;
        }
    }];
    
    // 3
    CGRect frame;
    frame.origin.x = _frame.origin.x + shortestRowWidth + _itemInsets.left;
    frame.origin.y = _frame.origin.y + (_rowHeigth * shortestRowIndex) + _itemInsets.top;
    frame.size = size;
    
    // 4
    _indexToFrameMap[@(index)] = [NSValue valueWithCGRect:frame];
    
    // 5
    if (CGRectGetMaxX(frame) > CGRectGetMaxX(_frame))
        _frame.size.width = (CGRectGetMaxX(frame) - _frame.origin.x) + _itemInsets.right;
    
    // 6
    [_rowWidths replaceObjectAtIndex:shortestRowIndex
                          withObject:@(shortestRowWidth + size.width + _itemInsets.right)];
    
//    DLog(@"frame %@ for index %d", NSStringFromCGRect(frame), index);
//    DLog(@"actual section frame %@", NSStringFromCGRect(_frame));
}

- (CGRect)frameForItemAtIndex:(NSInteger)index {
    return [_indexToFrameMap[@(index)] CGRectValue];
}

@end
