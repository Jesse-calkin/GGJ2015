//
//  GGJTimeline.m
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "GGJClock.h"
#import "NSTimer+CVPausable.h"

static const NSTimeInterval TickLength = 3;
static const NSUInteger GameLengthInTicks = 100;

NSString *const GGJClockTickElapsedNotification = @"GGJClockTickElapsedNotification";
NSString *const GGJTimeUpNotification = @"GGJTimeUpNotification";

@interface GGJClock ()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSUInteger elapsedTicks;

@end

@implementation GGJClock

- (instancetype )init
{
    if (self = [super init]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:TickLength target:self selector:@selector(handleTick) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)startClock
{
    if ([self.timer isPaused]) {
        [self.timer pauseOrResume];
    }
}

- (void)stopClock
{
    if (![self.timer isPaused]) {
        [self.timer pauseOrResume];
    }
}

- (void)handleTick
{
    [self incrementTicks];
}

- (void)incrementTicks
{
    self.elapsedTicks += 1;
    [self postNotification];
    [self checkForTimeUp];
}

- (void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:GGJClockTickElapsedNotification object:nil];
}

- (void)checkForTimeUp
{
    if (self.elapsedTicks >= GameLengthInTicks) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GGJTimeUpNotification object:nil];
    }
}

- (NSUInteger)percentageTimeElapsed
{
    return (((double)self.elapsedTicks / (double)GameLengthInTicks) * 100);
}

- (NSTimeInterval)tickLength
{
    return TickLength;
}
@end
