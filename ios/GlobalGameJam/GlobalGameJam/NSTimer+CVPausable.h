//
//  NSTimer+CVPausable.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (CVPausable)

- (void)pauseOrResume;
- (BOOL)isPaused;

@end