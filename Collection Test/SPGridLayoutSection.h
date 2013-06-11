//  SPGridLayoutSection.h
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

@interface SPGridLayoutSection : NSObject

@property (nonatomic, assign, readonly) CGRect frame;
@property (nonatomic, assign, readonly) UIEdgeInsets itemInsets;
@property (nonatomic, assign, readonly) CGFloat rowHeigth;
@property (nonatomic, assign, readonly) NSInteger numberOfItems;
@property (nonatomic, assign, readonly) CGSize headerSize;

- (id)initWithOrigin:(CGPoint)origin header:(CGSize)header heigth:(CGFloat)heigth rows:(NSInteger)rows itemInsets:(UIEdgeInsets)itemInsets;
- (void)addItemOfSize:(CGSize)size forIndex:(NSInteger)index;
- (CGRect)frameForItemAtIndex:(NSInteger)index;

@end
