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
static NSString * const GGJFillingAtlasName = @"filling";

@interface CoffeeScene ()
@property (nonatomic) CGRect coffeeRect;
@property (nonatomic, strong) SKSpriteNode *coffeeSprite;
@property (nonatomic, strong) SKSpriteNode *fillingSprite;
@property (nonatomic, strong) SKSpriteNode *blocker;
@property (nonatomic, strong) NSMutableArray *coffeeFrames;
@property (nonatomic, strong) NSMutableArray *fillingFrames;

@end

@implementation CoffeeScene

- (void)didMoveToView:(SKView *)view
{
    self.coffeeRect = CGRectMake(117.0, 200.0, 75.0, 130.0);
    
    self.view.showsFPS = YES;
    self.view.showsNodeCount = YES;

    [self setupBlocker];
    
    SKTextureAtlas *coffeeAtlas = [SKTextureAtlas atlasNamed:GGJCoffeeAtlasName];
    SKSpriteNode *coffeeButton = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:[[coffeeAtlas textureNames] lastObject]]];
    coffeeButton.position = CGPointMake(175, 225);
    coffeeButton.xScale = 3.0;
    coffeeButton.yScale = 3.0;
    [self addChild:coffeeButton];

    [self performSelector:@selector(setupTextureAtlas) withObject:nil afterDelay:0.33f];
}

#pragma mark - Sprite setup

- (void)setupBlocker
{
    self.blocker = [SKSpriteNode spriteNodeWithImageNamed:@"coffeeman"];
    self.blocker.position = CGPointMake(323.0, 310.0);
    self.blocker.texture.filteringMode = SKTextureFilteringNearest;
    self.blocker.xScale = -0.5;
    self.blocker.yScale = 0.5;
    
    SKAction *a1 = [SKAction moveByX:-150.0 y:0.0 duration:0.88];
    SKAction *r1 = [a1 reversedAction];
    SKAction *a2 = [SKAction moveByX:270.0 y:0.0 duration:1.15];
    SKAction *r2 = [a2 reversedAction];
    
    SKAction *chain = [SKAction sequence:@[a1, a2, r2, r1]];
    [self.blocker runAction:[SKAction repeatActionForever:chain]];
    
    [self addChild:self.blocker];
}

- (void)setupTextureAtlas
{
    //Coffee cup
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
    // Coffee filling animation
    
    self.fillingFrames = [NSMutableArray array];
    
    SKTextureAtlas *fillingAtlas = [SKTextureAtlas atlasNamed:GGJFillingAtlasName];
    
    for (NSString *texName in [fillingAtlas.textureNames sortedArrayUsingSelector:@selector(compare:)]) {
        [self.fillingFrames addObject:[fillingAtlas textureNamed:texName]];
    }
    self.fillingSprite = [SKSpriteNode spriteNodeWithTexture:self.fillingFrames[0]];
    self.fillingSprite.position = CGPointMake(859.0, 200.0);
    self.fillingSprite.texture.filteringMode = SKTextureFilteringNearest;
    self.fillingSprite.xScale = 6.0;
    self.fillingSprite.yScale = 6.0;
    self.fillingSprite.hidden = YES;
    
    [self addChild:self.fillingSprite];
    
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
            self.fillingSprite.hidden = NO;
            self.coffeeSprite.paused = NO;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches ended");
    self.coffeeSprite.paused = YES;
    self.fillingSprite.hidden = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches moved");
    self.coffeeSprite.paused = YES;
    self.fillingSprite.hidden = YES;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.coffeeSprite.paused = YES;
//    self.fillingSprite.hidden = YES;
}

#pragma mark - Actions

- (void)fillHerUp
{
    SKAction *fillAction = [SKAction animateWithTextures:self.coffeeFrames timePerFrame:1.33f];
    [self.coffeeSprite runAction:fillAction completion:^{
        [self winnerWinnerChickenDinner];
    }];
    SKAction *fillingIndicator = [SKAction animateWithTextures:self.fillingFrames timePerFrame:0.25];
    [self.fillingSprite runAction:[SKAction repeatActionForever:fillingIndicator]];
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


