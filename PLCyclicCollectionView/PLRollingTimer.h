//
//  PLRollingTimer.h
//  PLCyclicView
//
//  Created by Plan on 16/2/16.
//  Copyright © 2016年 PLAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PLRollingTimerDelegate <NSObject>

- (void)onRollingTimer;

@end

@interface PLRollingTimer : NSObject

@property (nonatomic,assign) id <PLRollingTimerDelegate> delegate;
@property (nonatomic,assign) NSTimeInterval timeInterval;

- (void)stop;
- (void)restart;

@end
