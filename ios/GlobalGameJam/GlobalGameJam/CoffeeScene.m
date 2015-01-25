//
//  CoffeeScene.m
//  GlobalGameJam
//
//  Created by jesse calkin on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "CoffeeScene.h"
#import "SKScene+Additions.h"

static NSString * const GGJCoffeeAtlasName = @"Coffee";

@interface CoffeeScene ()
@property (nonatomic) CGRect coffeeRect;
@property (nonatomic, strong) SKSpriteNode *coffeeSprite;
@property (nonatomic, strong) SKSpriteNode *blocker;
@property (nonatomic, strong) NSMutableArray *coffeeFrames;
@end

@implementation CoffeeScene

- (void)didMoveToView:(SKView *)view
{
    self.coffeeRect = CGRectMake(117.0, 200.0, 75.0, 130.0);
    
    self.view.showsFPS = YES;
    self.view.showsNodeCount = YES;

    [self setupBlocker];

    [self performSelector:@selector(setupTextureAtlas) withObject:nil afterDelay:0.33f];
}

#pragma mark - Sprite setup

- (void)setupBlocker
{
    self.blocker = [SKSpriteNode spriteNodeWithImageNamed:@"snakeLava"];
    self.blocker.position = CGPointMake(323.0, 310.0);
    self.blocker.texture.filteringMode = SKTextureFilteringNearest;
    self.blocker.xScale = 4.4;
    self.blocker.yScale = 4.4;
    
    SKAction *a1 = [SKAction moveByX:-230.0 y:0.0 duration:0.88];
    SKAction *r1 = [a1 reversedAction];
    SKAction *a2 = [SKAction moveByX:75.0 y:0.0 duration:0.33];
    SKAction *r2 = [a2 reversedAction];
    
    SKAction *chain = [SKAction sequence:@[a1, a2, r2, r1]];
    [self.blocker runAction:[SKAction repeatActionForever:chain]];
    
    [self addChild:self.blocker];
}

- (void)setupTextureAtlas
{
    self.coffeeFrames = [NSMutableArray array];
    
    SKTextureAtlas *coffeeAtlas = [SKTextureAtlas atlasNamed:GGJCoffeeAtlasName];
    
    for (NSString *texName in [coffeeAtlas.textureNames sortedArrayUsingSelector:@selector(compare:)]) {
        [self.coffeeFrames addObject:[coffeeAtlas textureNamed:texName]];
    }
    self.coffeeSprite = [SKSpriteNode spriteNodeWithTexture:self.coffeeFrames[0]];
    self.coffeeSprite.position = CGPointMake(910.0, 90.0);
    self.coffeeSprite.texture.filteringMode = SKTextureFilteringNearest;
    self.coffeeSprite.xScale = 6.0;
    self.coffeeSprite.yScale = 6.0;
    
    [self addChild:self.coffeeSprite];
    
    [self fillHerUp];
}


#pragma mark - touches


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"Tapped point: %f,%f", location.x, location.y);
        BOOL hitCoffee = location.x > self.coffeeRect.origin.x && location.x < (self.coffeeRect.origin.x + self.coffeeRect.size.width) && location.y > self.coffeeRect.origin.y && location.y < (self.coffeeRect.origin.y + self.coffeeRect.size.height);
        BOOL blocked = CGRectContainsPoint(self.blocker.frame, location);
        
        if (hitCoffee && !blocked) {
            NSLog(@"Hit the coffee!");
            self.coffeeSprite.paused = NO;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches ended");
    self.coffeeSprite.paused = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches moved");
    self.coffeeSprite.paused = YES;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.coffeeSprite.paused = YES;
}

#pragma mark - Actions

- (void)fillHerUp
{
    SKAction *fillAction = [SKAction animateWithTextures:self.coffeeFrames timePerFrame:1.33f];
    [self.coffeeSprite runAction:fillAction completion:^{
        [self winnerWinnerChickenDinner];
    }];
    self.coffeeSprite.paused = YES;
}

- (void)winnerWinnerChickenDinner
{
    NSLog(@"WIN!");
    NSNumber *win = [NSNumber numberWithBool:YES];
    [self.sceneDelegate scene:self finishedWithContext:win];
}

- (void)lose
{
    NSLog(@"LOSE!");
    NSNumber *lose = [NSNumber numberWithBool:NO];
    [self.sceneDelegate scene:self finishedWithContext:lose];
}

@end


