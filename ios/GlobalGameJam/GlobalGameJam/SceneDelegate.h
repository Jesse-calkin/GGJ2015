//
//  SceneDelegate.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  
//

#import <SpriteKit/SpriteKit.h>

@protocol SceneDelegate <NSObject>
- (void)sceneFinished:(SKScene *)scene;
- (void)scene:(SKScene *)scene finishedWithContext:(id)context;
@end
