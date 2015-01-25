//
//  GGJTimeline.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const GGJClockTickElapsedNotification;
extern NSString *const GGJTimeUpNotification;

@interface GGJClock : NSObject

// Just use this for now
- (void)startClock;
- (void)stopClock;
- (void)incrementTicks; // please don't call this

@property (nonatomic, readonly) NSUInteger percentageTimeElapsed;

@end
