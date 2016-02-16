//
//  PLCollectionViewDelegate.m
//  PLCyclicView
//
//  Created by Plan on 16/2/15.
//  Copyright © 2016年 PLAN. All rights reserved.
//

#import "PLCRCollectionViewDataSource.h"
#import "PLCRCollectionViewCell.h"

@implementation PLCRCollectionViewDataSource

- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = nil;
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:dataSource];
    if (dataSource.count > 1) {
        [tempArray insertObject:dataSource.lastObject atIndex:0];
        [tempArray insertObject:dataSource.firstObject atIndex:dataSource.count+1];
    }
    _dataSource = tempArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLCRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell setImageNamed:self.dataSource[indexPath.row]];
    return cell;
}

@end
