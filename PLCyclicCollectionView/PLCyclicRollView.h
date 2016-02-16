//
//  PLCyclicView.h
//  PLCyclicView
//
//  Created by Plan on 16/1/21.
//  Copyright © 2016年 PLAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLRollingTimer.h"

@class PLCyclicRollView;
@protocol PLCyclicRollViewDelegate <NSObject>

- (void)rollView:(PLCyclicRollView *)rollView didSelectItemAtIndex:(NSInteger)index;

@end


@interface PLCyclicRollView : UIView <PLRollingTimerDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign) id <PLCyclicRollViewDelegate> delegate;

///set image url （imageName，filePath，imageURL）
@property(nonatomic, assign) NSArray *imageURLs;

///Automatic rolling    (default: YES)
@property (nonatomic, assign) BOOL autoRollingEnabled;
///Automatic rolling time interval (default: 4.0s)
@property (nonatomic, assign) NSTimeInterval timeInterval;

@end
