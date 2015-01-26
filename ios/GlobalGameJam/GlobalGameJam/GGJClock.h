//
//  GGJTimeline.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  
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
@property (nonatomic, readonly) NSTimeInterval tickLength;
@property (nonatomic, readonly) NSTimeInterval timeElapsed;

@end
