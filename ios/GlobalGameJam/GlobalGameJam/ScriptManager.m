//
//  ScriptManager.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  
//

#import "ScriptManager.h"
#import "GGJClock.h"
#import "GGJDecisionPoint.h"
#import "GGJGameStateManager.h"
#import "MiniGameScriptPoint.h"
#import "GGJDecisionPointChoice.h"

static NSArray *AllScriptPoints;
static NSArray *MiniGameScriptPoints;
static NSArray *DecisionPoints;

@implementation ScriptManager

#pragma mark - Public class

+ (NSArray *)allScriptPoints
{
    if (AllScriptPoints == nil) {
        NSArray *miniGameScriptPoints = [self miniGameScriptPoints];
        NSArray *decisionPoints = [self decisionPoints];
        NSArray *allScriptPoints = [miniGameScriptPoints arrayByAddingObjectsFromArray:decisionPoints];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"scheduledTime" ascending:YES];
        NSArray *sortDescriptors = @[sortDescriptor];
        AllScriptPoints = [allScriptPoints sortedArrayUsingDescriptors:sortDescriptors];
    }
    
    return AllScriptPoints;
}

+ (id<ScriptPoint>)currentScriptPoint
{
    NSTimeInterval timeElapsed = [[[GGJGameStateManager sharedInstance] clock] timeElapsed];
    NSArray *allUnhandledScriptPoints = [self allUnhandledScriptPoints];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"scheduledTime <= %f", timeElapsed];
    NSArray *allUnhandledScriptPointsOnDeck = [allUnhandledScriptPoints filteredArrayUsingPredicate:predicate];
    id<ScriptPoint> currentScriptPoint = [allUnhandledScriptPointsOnDeck firstObject];
    return currentScriptPoint;
}

#pragma mark - Private class

+ (NSArray *)allUnhandledScriptPoints
{
    NSArray *allScriptPoints = [self allScriptPoints];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"handled == NO"];
    NSArray *allUnhandledScriptPoints = [allScriptPoints filteredArrayUsingPredicate:predicate];
    return allUnhandledScriptPoints;
}

+ (NSArray *)miniGameScriptPoints
{
    if (MiniGameScriptPoints == nil) {
        NSMutableArray *miniGameScriptPoints = [NSMutableArray array];
        NSArray *plistArray = [self arrayFromPlist:@"Script"];
        [plistArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL *stop) {
            MiniGameScriptPoint *miniGameScriptPoint = [self miniGameScriptPointForDictionary:dictionary];
            [miniGameScriptPoints addObject:miniGameScriptPoint];
        }];
        MiniGameScriptPoints = miniGameScriptPoints;
    }
    
    return MiniGameScriptPoints;
}

+ (NSArray *)decisionPoints
{
    if (DecisionPoints == nil) {
        NSMutableArray *decisionPoints = [NSMutableArray array];
        NSArray *plistArray = [self arrayFromPlist:@"DecisionPoints"];
        [plistArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger index, BOOL *stop) {
            GGJDecisionPoint *decisionPoint = [self decisionPointForDictionary:dictionary];
            [decisionPoints addObject:decisionPoint];
        }];
        DecisionPoints = decisionPoints;
    }
    
    return DecisionPoints;
}

+ (NSArray *)arrayFromPlist:(NSString *)plist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

+ (GGJDecisionPoint *)decisionPointForDictionary:(NSDictionary *)dictionary
{
    GGJDecisionPoint *decisionPoint = [[GGJDecisionPoint alloc] init];
    decisionPoint.handled = NO;
    decisionPoint.scheduledTime = [dictionary[@"scheduledTime"] doubleValue];
    NSDictionary *yesDictionary = (NSDictionary* )dictionary[@"Yes"];
    NSDictionary *noDictionary = (NSDictionary* )dictionary[@"No"];
    decisionPoint.promptText = dictionary[@"prompt"];
    
    GGJDecisionPointChoice *yesDecision = [[GGJDecisionPointChoice alloc] init];
    yesDecision.correct = YES;
    yesDecision.optionText = yesDictionary[@"Choice"];
    yesDecision.resultText = yesDictionary[@"Result"];
    
    GGJDecisionPointChoice *noDecision = [[GGJDecisionPointChoice alloc] init];
    noDecision.correct = NO;
    noDecision.optionText = noDictionary[@"Choice"];
    noDecision.resultText = noDictionary[@"Result"];
    
    decisionPoint.choices = @[yesDecision, noDecision];
   
    return decisionPoint;
}

+ (MiniGameScriptPoint *)miniGameScriptPointForDictionary:(NSDictionary *)dictionary
{
    MiniGameScriptPoint *miniGameScriptPoint = [[MiniGameScriptPoint alloc] init];
    miniGameScriptPoint.duration = [dictionary[@"duration"] floatValue];
    miniGameScriptPoint.handled = NO;
    miniGameScriptPoint.scheduledTime = [dictionary[@"scheduledTime"] doubleValue];
    miniGameScriptPoint.viewControllerClassName = dictionary[@"viewControllerClassName"];
    return miniGameScriptPoint;
}

@end
