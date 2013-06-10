//
//  SPViewController.m
//  SPMosaicCollectionView
//
//  Created by specktro on 06/06/13.
//  Copyright (c) 2013 specktro. All rights reserved.
//

#import "SPViewController.h"

@interface SPViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    SPGridLayout *gridLayout = [[SPGridLayout alloc] init];
    gridLayout.headerWidth = 0.0f;
    self.collectionView.collectionViewLayout = gridLayout;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 453;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random()%255) / 255.0f green:(arc4random()%255) / 255.0f blue:(arc4random()%255) / 255.0f alpha:1.0f];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Selectors
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"select item at indexPath > %@", indexPath);
}

#pragma mark - BBGridLayoutDelegate Selectors
- (NSInteger)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl sizeForItemWithHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(arc4random() % 500, height);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl itemInsetsForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
}


@end
