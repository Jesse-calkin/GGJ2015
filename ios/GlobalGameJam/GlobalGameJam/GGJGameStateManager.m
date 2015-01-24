//
//  GGJGameStateManager.m
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "GGJGameStateManager.h"
#import "GGJClock.h"

NSString *const GGJGameOverNotification = @"GGJGameOverNotification";

@implementation GGJGameStateManager

- (void)startGame
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTimeUp) name:GGJTimeUpNotification object:nil];
    self.clock = [[GGJClock alloc] init];
}

- (void)handleTimeUp
{
    NSLog(@"TIME UP MOTHERFUCKER");
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


@end
