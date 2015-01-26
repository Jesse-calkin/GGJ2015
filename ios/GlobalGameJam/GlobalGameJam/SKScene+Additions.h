//
//  SKScene+Additions.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  
//

#import <SpriteKit/SpriteKit.h>
#import "SceneDelegate.h"

@interface SKScene (Additions)

@property (weak, nonatomic) id<SceneDelegate> sceneDelegate;

@end

