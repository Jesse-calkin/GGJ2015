//
//  CoffeeViewController.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "CoffeeViewController.h"
#import "CoffeeScene.h"
#import "SceneManager.h"

@interface CoffeeViewController ()
@property (strong, nonatomic) CoffeeScene *coffeeScene;
@property (strong, nonatomic) SKView *skView;
@end

@implementation CoffeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect skViewFrame = self.view.bounds;
    self.skView = [[SKView alloc] initWithFrame:skViewFrame];
    self.skView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.skView];
    
    self.coffeeScene = (CoffeeScene *)[SceneManager sceneWithName:CoffeeSceneName];
    [self.skView presentScene:self.coffeeScene];
}

@end
