//  SPViewController.m
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

#import "SPViewController.h"

@interface SPViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"itemIdentifier"];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"headerIdentifier"];
    SPGridLayout *gridLayout = [[SPGridLayout alloc] init];
    gridLayout.headerWidth = 0.0f;
    self.collectionView.collectionViewLayout = gridLayout;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section ? 5 : 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%255) / 255.0f green:(arc4random()%255) / 255.0f blue:(arc4random()%255) / 255.0f alpha:1.0f];
    return cell;
}

#pragma mark - UICollectionViewDelegate Selectors
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                          withReuseIdentifier:@"headerIdentifier"
                                                                                 forIndexPath:indexPath];
    header.backgroundColor = [UIColor whiteColor];
    header.layer.borderColor = [UIColor redColor].CGColor;
    header.layer.borderWidth = 3.0f;
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"select item at indexPath > %@", indexPath);
}

#pragma mark - BBGridLayoutDelegate Selectors
- (NSInteger)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl sizeForItemWithHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(arc4random() % 500, height);;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl itemInsetsForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
}

- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl sizeForHeaderAtSection:(NSInteger)section {
    return CGSizeMake(arc4random() % 250, self.collectionView.bounds.size.height);
}


@end
