//
//  GGJGameStateManager.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  
//

#import <Foundation/Foundation.h>

@class GGJClock;
@class GGJDecisionPointChoice;

extern NSString *const GGJGameOverNotification;
extern NSString *const GGJScoreChangedNotification;

@interface GGJGameStateManager : NSObject

@property (nonatomic) GGJClock *clock;
@property (nonatomic,readonly) NSUInteger score;

+ (instancetype)sharedInstance;

- (void)startGame;

- (void)handleDecisionPointChoice:(GGJDecisionPointChoice *)choice;
- (void)handleMinigameWon:(BOOL)won;

@end
