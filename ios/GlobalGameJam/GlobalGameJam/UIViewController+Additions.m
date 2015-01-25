//
//  UIViewController+Additions.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "UIViewController+Additions.h"
#import "SceneManager.h"
#import "SKScene+Additions.h"
#import <CoreImage/CoreImage.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"

@implementation UIViewController (Additions)

static void *AssociationKey;

#pragma mark - Public

- (void)configureForScene {
    Class class = [self class];
    NSString *className = NSStringFromClass(class);
    NSString *sceneName = [className stringByReplacingOccurrencesOfString:@"ViewController" withString:@"Scene"];
    [self configureForSceneNamed:sceneName];
}

- (void)configureForScene:(SKScene *)scene {
    scene.sceneDelegate = self;
    
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
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    [self presentViewController:viewController animated:YES completion:completion];
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

#pragma mark - <UIViewControllerAnimatedTransitioning>

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL goingBackHome = [toViewController isKindOfClass:[MainViewController class]];
    
    UIViewController *mainViewController = fromViewController;
    UIViewController *gameViewController = toViewController;
    
    if (goingBackHome) {
        mainViewController = toViewController;
        gameViewController = fromViewController;
    }
    
    CGFloat smallSize = 0.01f;
    CGFloat normalSize = 1.0f;
    CGFloat bigSize = 4.5f;
    
    if (gameViewController.view.superview != containerView) {
        [containerView addSubview:gameViewController.view];
        gameViewController.view.frame = containerView.bounds;
    }
    
    if (goingBackHome == NO) {
        [self applyScale:smallSize toView:gameViewController.view];
    }
    
    UIViewAnimationOptions options = (goingBackHome ? UIViewAnimationOptionCurveEaseOut : UIViewAnimationOptionCurveEaseIn);
    
    [UIView animateWithDuration:0.6f delay:0.0f options:options animations:^{
        if (goingBackHome) {
            [self applyScale:normalSize toView:mainViewController.view];
            [self applyScale:smallSize toView:gameViewController.view];
        }
        else {
            [self applyScale:normalSize toView:gameViewController.view];
            [self applyScale:bigSize toView:mainViewController.view];
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 5.0f;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    
}

#pragma mark - Private class

+ (UIImage *)pixelatedImageOfView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *imageOfView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CIImage *input = [CIImage imageWithCGImage:imageOfView.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate" keysAndValues:kCIInputImageKey, input, nil];
    CIImage *output = [filter valueForKey:kCIOutputImageKey];
    UIImage *pixelated = [UIImage imageWithCIImage:output];
    return pixelated;
}

+ (UIImage *)pixelatedImageOfViewController:(UIViewController *)viewController {
    UIImage *pixelatedImage = [self pixelatedImageOfView:viewController.view];
    return pixelatedImage;
}

- (void)applyScale:(CGFloat)scale toView:(UIView *)view
{
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    view.layer.affineTransform = transform;
}

#pragma mark - <SceneDelegate>

- (void)sceneFinished:(SKScene *)scene {
    if ([self.gameViewControllerDelegate respondsToSelector:@selector(gameViewControllerFinished:)]) {
        [self.gameViewControllerDelegate gameViewControllerFinished:self];
    }
}

- (void)scene:(SKScene *)scene finishedWithContext:(id)context {
    if ([self.gameViewControllerDelegate respondsToSelector:@selector(gameViewController:finishedWithContext:)]) {
        [self.gameViewControllerDelegate gameViewController:self finishedWithContext:context];
    }
}

#pragma mark - Accessors

- (void)setGameViewControllerDelegate:(id<GameViewControllerDelegate>)gameViewControllerDelegate {
    objc_setAssociatedObject(self, AssociationKey, gameViewControllerDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<GameViewControllerDelegate>)gameViewControllerDelegate {
    return objc_getAssociatedObject(self, AssociationKey);
}

@end
