//
//  SceneManager.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "SceneManager.h"

@implementation SceneManager

#pragma mark - Public

+ (SKScene *)sceneAtIndex:(NSInteger)index
{
    return nil;
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

@end
