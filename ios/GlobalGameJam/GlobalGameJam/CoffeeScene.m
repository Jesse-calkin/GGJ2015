//
//  CoffeeScene.m
//  GlobalGameJam
//
//  Created by jesse calkin on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "CoffeeScene.h"

static NSString * const GGJCoffeeAtlasName = @"Coffee";

@interface CoffeeScene ()
@property (nonatomic) CGRect coffeeRect;
@property (nonatomic, strong) SKSpriteNode *coffeeSprite;
@property (nonatomic, strong) NSMutableArray *coffeeFrames;
@end

@implementation CoffeeScene

- (void)didMoveToView:(SKView *)view
{
    [self setupTextureAtlas];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"Tapped point: %f,%f", location.x, location.y);
    }
}

- (void)setupTextureAtlas
{
    self.coffeeFrames = [NSMutableArray array];
    
    SKTextureAtlas *coffeeAtlas = [SKTextureAtlas atlasNamed:GGJCoffeeAtlasName];
    
    for (NSString *texName in [coffeeAtlas.textureNames sortedArrayUsingSelector:@selector(compare:)]) {
        NSLog(@"Adding frame: %@", texName);
        [self.coffeeFrames addObject:[coffeeAtlas textureNamed:texName]];
    }
    self.coffeeSprite = [SKSpriteNode spriteNodeWithTexture:self.coffeeFrames[0]];
    self.coffeeSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.coffeeSprite.texture.filteringMode = SKTextureFilteringNearest;
    self.coffeeSprite.xScale = 3.0;
    self.coffeeSprite.yScale = 3.0;
    
    [self addChild:self.coffeeSprite];
    
    [self fillHerUp];
}

- (void)fillHerUp
{
    SKAction *fillAction = [SKAction animateWithTextures:self.coffeeFrames timePerFrame:0.33f];
    [self.coffeeSprite runAction:[SKAction repeatActionForever:fillAction]];
}
@end
