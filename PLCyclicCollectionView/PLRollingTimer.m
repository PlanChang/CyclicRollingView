//
//  PLRollingTimer.m
//  PLCyclicView
//
//  Created by Plan on 16/2/16.
//  Copyright © 2016年 PLAN. All rights reserved.
//

#import "PLRollingTimer.h"

@implementation PLRollingTimer
{
    NSTimer *_timer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeInterval = 4.0;
        [self setupTimer];
    }
    return self;
}

- (void)onTimer
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // something
        if ([self.delegate respondsToSelector:@selector(onRollingTimer)]) {
           [self.delegate onRollingTimer];
        }
    });
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
}

- (void)restart
{
    [self stop];
    [self setupTimer];
}

- (void)setupTimer
{
    if(!_timer){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
            _timer = timer;
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        });
    }
}

@end
