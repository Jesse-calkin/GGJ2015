//
//  SKScene+Additions.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol SceneDelegate;

@interface SKScene (Additions)

@property (weak, nonatomic) id<SceneDelegate> sceneDelegate;

@end

@protocol SceneDelegate <NSObject>
- (void)sceneFinished:(SKScene *)scene;
@end
