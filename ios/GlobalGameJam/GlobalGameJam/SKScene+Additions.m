//
//  SKScene+Additions.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  
//

#import "SKScene+Additions.h"
#import <objc/runtime.h>

@implementation SKScene (Additions)

static void *AssociationKey;

- (void)setSceneDelegate:(id<SceneDelegate>)sceneDelegate {
    objc_setAssociatedObject(self, AssociationKey, sceneDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<SceneDelegate>)sceneDelegate {
    return objc_getAssociatedObject(self, AssociationKey);
}

@end
