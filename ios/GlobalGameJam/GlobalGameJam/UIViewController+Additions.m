//
//  UIViewController+Additions.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "UIViewController+Additions.h"
#import "SceneManager.h"

@implementation UIViewController (Additions)

- (void)configureForScene {
    Class class = [self class];
    NSString *className = NSStringFromClass(class);
    NSString *sceneName = [className stringByReplacingOccurrencesOfString:@"ViewController" withString:@"Scene"];
    [self configureForSceneNamed:sceneName];
}

- (void)configureForScene:(SKScene *)scene {
    CGRect frame = self.view.bounds;
    SKView *skView = [[SKView alloc] initWithFrame:frame];
    skView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:skView];
    
    [skView presentScene:scene];
}

- (void)configureForSceneNamed:(NSString *)sceneName {
    SKScene *scene = [SceneManager sceneWithName:sceneName];
    [self configureForScene:scene];
}

- (void)switchToViewController:(UIViewController *)viewController completion:(void (^)(void))completion {
    [self presentViewController:viewController animated:YES completion:completion];
}

@end
