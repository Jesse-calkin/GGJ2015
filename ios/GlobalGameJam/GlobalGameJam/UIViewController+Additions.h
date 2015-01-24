//
//  UIViewController+Additions.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface UIViewController (Additions)

- (void)configureForScene;
- (void)configureForScene:(SKScene *)scene;
- (void)configureForSceneNamed:(NSString *)sceneName;

@end
