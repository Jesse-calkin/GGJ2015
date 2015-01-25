//
//  UIViewController+Additions.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "SKScene+Additions.h"

@interface UIViewController (Additions) <SceneDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

- (void)configureForScene;
- (void)configureForScene:(SKScene *)scene;
- (void)configureForSceneNamed:(NSString *)sceneName;

- (void)switchToViewController:(UIViewController *)viewController completion:(void (^)(void))completion;

@end
