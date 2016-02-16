//
//  PLCollectionViewDelegate.h
//  PLCyclicView
//
//  Created by Plan on 16/2/15.
//  Copyright © 2016年 PLAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define cellId @"contentCell"

@interface PLCRCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;

@end
