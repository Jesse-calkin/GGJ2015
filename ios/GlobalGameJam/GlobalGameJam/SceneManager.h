//
//  SceneManager.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

@interface SceneManager : NSObject

+ (SKScene *)sceneAtIndex:(NSInteger)index;
+ (SKScene *)sceneWithName:(NSString *)name;

@end
