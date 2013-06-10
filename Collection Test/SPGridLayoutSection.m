//  SPGridLayoutSection.m
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
