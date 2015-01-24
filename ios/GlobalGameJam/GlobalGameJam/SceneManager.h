//
//  SceneManager.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

extern NSString * const CoffeeSceneName;
extern NSString * const GameSceneName;
extern NSString * const HackSceneName;
extern NSString * const PlanningSceneName;

@interface SceneManager : NSObject

+ (SKScene *)sceneAtIndex:(NSInteger)index;
+ (SKScene *)sceneWithName:(NSString *)name;

@end
