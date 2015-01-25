//
//  ScriptManager.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "ScriptManager.h"
#import "GGJDecisionPoint.h"
#import "MiniGameScriptPoint.h"

static NSArray *MiniGameScriptPoints;
static NSArray *DecisionPoints;

@implementation ScriptManager

#pragma mark - Public class

+ (NSArray *)allScriptPoints
{
    NSArray *miniGameScriptPoints = [self miniGameScriptPoints];
    NSArray *decisionPoints = [self decisionPoints];
    NSArray *allScriptPoints = [miniGameScriptPoints arrayByAddingObjectsFromArray:decisionPoints];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"scheduledTime" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    allScriptPoints = [allScriptPoints sortedArrayUsingDescriptors:sortDescriptors];
    return allScriptPoints;
}

+ (id<ScriptPoint>)currentScriptPoint
{
    return nil;
}

#pragma mark - Private class

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
