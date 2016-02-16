//
//  PLCyclicCollectionViewCell.m
//  PLCyclicView
//
//  Created by Plan on 16/2/16.
//  Copyright © 2016年 PLAN. All rights reserved.
//

#import "PLCRCollectionViewCell.h"

@implementation PLCRCollectionViewCell
{
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.frame = self.bounds;
        [self addSubview:_imageView];
    }
}

- (void)setImageNamed:(NSString *)imageName
{
    if (imageName.length > 0) {
        _imageView.image = [UIImage imageNamed:imageName];
    }
}

@end
