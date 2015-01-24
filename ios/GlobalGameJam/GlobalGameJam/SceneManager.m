//
//  SceneManager.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "SceneManager.h"

NSString * const CoffeeSceneName = @"CoffeeScene";
NSString * const GameSceneName = @"GameScene";
NSString * const HackSceneName = @"HackScene";

@implementation SceneManager

#pragma mark - Public

+ (SKScene *)sceneAtIndex:(NSInteger)index
{
    NSString *sceneName = [self sceneNameAtIndex:index];
    SKScene *scene = [self sceneWithName:sceneName];
    return scene;
}

+ (SKScene *)sceneWithName:(NSString *)name
{
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:name ofType:@"sks"];
    NSData *data = [NSData dataWithContentsOfFile:nodePath options:NSDataReadingMappedIfSafe error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Class sceneClass = NSClassFromString(name);
    [arch setClass:sceneClass forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    return scene;
}

#pragma mark - Private

+ (NSArray *)sceneNames
{
    NSArray *sceneNames = @[GameSceneName, CoffeeSceneName, HackSceneName];
    return sceneNames;
}

+ (NSString *)sceneNameAtIndex:(NSInteger)index
{
    NSArray *sceneNames = [self sceneNames];
    NSString *sceneName = sceneNames[index];
    return sceneName;
}

@end
