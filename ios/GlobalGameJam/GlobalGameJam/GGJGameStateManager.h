//
//  GGJGameStateManager.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GGJClock;

extern NSString *const GGJGameOverNotification;

@interface GGJGameStateManager : NSObject

@property (nonatomic) GGJClock *clock;

+ (instancetype)sharedInstance;

- (void)startGame;

@end
