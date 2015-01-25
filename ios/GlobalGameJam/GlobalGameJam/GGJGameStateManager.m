//
//  GGJGameStateManager.m
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "GGJGameStateManager.h"
#import "GGJClock.h"
#import "GGJDecisionPointChoice.h"


NSString *const GGJGameOverNotification = @"GGJGameOverNotification";
NSString *const GGJScoreChangedNotification = @"GGJScoreChangedNotification";

@interface GGJGameStateManager ()

@property (nonatomic,readwrite) NSUInteger score;

@end

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


- (void)handleDecisionPointChoice:(GGJDecisionPointChoice *)choice
{
    if (choice.correct) {
        self.score += 500;
    }
    else {
        // we accelerate the clock 2% on a poor decision
        [self.clock incrementTicks];
        [self.clock incrementTicks];
    }
}

- (void)handleMinigameWon:(BOOL)won
{
    if (won) {
        self.score += 1000;
    }
}


- (void)setScore:(NSUInteger)score
{
    _score = score;
    [[NSNotificationCenter defaultCenter] postNotificationName:GGJScoreChangedNotification object:nil];
}


@end
