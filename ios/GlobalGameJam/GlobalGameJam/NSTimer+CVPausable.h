//
//  NSTimer+CVPausable.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  
//

#import <Foundation/Foundation.h>

@interface NSTimer (CVPausable)

- (void)pauseOrResume;
- (BOOL)isPaused;

@end