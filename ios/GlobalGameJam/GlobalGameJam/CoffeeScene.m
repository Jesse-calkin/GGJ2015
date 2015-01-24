//
//  CoffeeScene.m
//  GlobalGameJam
//
//  Created by jesse calkin on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "CoffeeScene.h"

@implementation CoffeeScene

- (void)didMoveToView:(SKView *)view
{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"snakeLava"];
    sprite.position = CGPointMake(323.0, 310.0);
    
    sprite.xScale = 4.4;
    sprite.yScale = 4.4;
    
    SKAction *action = [SKAction moveByX:-200.0 y:0.0 duration:0.88];
    SKAction *reverseAction = [action reversedAction];
    
    SKAction *chain = [SKAction sequence:@[action, reverseAction]];
    [sprite runAction:[SKAction repeatActionForever:chain]];
    
    [self addChild:sprite];
}

@end
