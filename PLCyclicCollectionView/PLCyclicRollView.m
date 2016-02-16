//
//  PLCyclicView.m
//  PLCyclicView
//
//  Created by Plan on 16/1/21.
//  Copyright © 2016年 PLAN. All rights reserved.
//

#import "PLCyclicRollView.h"
#import "PLCRCollectionViewCell.h"
#import "PLCRCollectionViewDataSource.h"

@interface PLCyclicRollView()
{
    NSInteger _currIndex;
}

@property (nonatomic, strong) UICollectionView *contentView;
@property (nonatomic, strong) PLCRCollectionViewDataSource *ViewDelegate;
@property (nonatomic, strong) PLRollingTimer *timer;

@end

@implementation PLCyclicRollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultConfig];
        [self setupTimer];
        [self setupContentView];
    }
    return self;
}

- (void)defaultConfig
{
    self.clipsToBounds = YES;
    self.autoRollingEnabled = YES;
    self.timeInterval = 4;
    self.ViewDelegate = [PLCRCollectionViewDataSource new];
}

- (void)setupContentView
{
    [self addSubview:self.contentView];
}

- (UICollectionView *)contentView
{
    if (!_contentView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = _ViewDelegate;
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[PLCRCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _contentView = collectionView;
    }
    return _contentView;
}

- (void)setupTimer
{
    if(_autoRollingEnabled && !_timer){
        _timer = [[PLRollingTimer alloc] init];
        _timer.delegate = self;
    }
}

- (void)layoutSubviews
{
    self.contentView.frame = self.bounds;
    [self.contentView reloadData];
}

#pragma mark - setter
- (void)setImageURLs:(NSArray *)imageURLs
{
    if (![_ViewDelegate.dataSource isEqual:imageURLs]) {
        _ViewDelegate.dataSource = imageURLs;
        [self.contentView reloadData];
        
        if (imageURLs.count > 1) {
            [self.contentView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
    }
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    _timer.timeInterval = timeInterval;
    [_timer restart];
}

#pragma mark - Timer

- (void)onRollingTimer
{
    NSInteger toIndex = _currIndex + 1;
    if (toIndex < self.ViewDelegate.dataSource.count) {
        [self.contentView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

#pragma mark - collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(rollView:didSelectItemAtIndex:)]) {
        NSInteger index = indexPath.row;
        if (self.ViewDelegate.dataSource.count == 1) {
            index = indexPath.row;
        } else if (indexPath.row == 0) {
            index = self.ViewDelegate.dataSource.count-2;
        } else if (indexPath.row == self.ViewDelegate.dataSource.count -1) {
            index = 0;
        } else {
            index = indexPath.row - 1;
        }
        [self.delegate rollView:self didSelectItemAtIndex:index];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size;
}

#pragma mark - scroller delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer stop];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_timer restart];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    _currIndex = scrollView.contentOffset.x / width;
    if (_currIndex == self.ViewDelegate.dataSource.count-1) {
        [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        _currIndex = 1;
    } else if (_currIndex == 0) {
        [scrollView setContentOffset:CGPointMake((self.ViewDelegate.dataSource.count-2) * width, 0) animated:NO];
        _currIndex = self.ViewDelegate.dataSource.count - 2;
    }
}

@end
