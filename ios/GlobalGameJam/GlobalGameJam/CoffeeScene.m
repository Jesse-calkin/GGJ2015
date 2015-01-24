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
    sprite.texture.filteringMode = SKTextureFilteringNearest;
    
    sprite.xScale = 4.4;
    sprite.yScale = 4.4;
    
    SKAction *a1 = [SKAction moveByX:-230.0 y:0.0 duration:0.88];
    SKAction *r1 = [a1 reversedAction];
    SKAction *a2 = [SKAction moveByX:75.0 y:0.0 duration:0.33];
    SKAction *r2 = [a2 reversedAction];
    
    SKAction *chain = [SKAction sequence:@[a1, a2, r2, r1]];
    [sprite runAction:[SKAction repeatActionForever:chain]];
    
    [self addChild:sprite];
}

@end
