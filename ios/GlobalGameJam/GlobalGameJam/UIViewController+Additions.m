//
//  UIViewController+Additions.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "UIViewController+Additions.h"
#import "SceneManager.h"
#import <CoreImage/CoreImage.h>

@implementation UIViewController (Additions)

#pragma mark - Public

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
    //viewController.modalPresentationStyle = UIModalPresentationCustom;
    //viewController.transitioningDelegate = self;
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
    UIImage *fromViewControllerImage = [[self class] pixelatedImageOfViewController:fromViewController];
    UIImageView *fromViewControllerImageView = [[UIImageView alloc] initWithImage:fromViewControllerImage];
    fromViewControllerImageView.alpha = 0.0f;
    [containerView addSubview:fromViewControllerImageView];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIImage *toViewControllerImage = [[self class] pixelatedImageOfViewController:toViewController];
    UIImageView *toViewControllerImageView = [[UIImageView alloc] initWithImage:toViewControllerImage];
    toViewControllerImageView.alpha = 0.0f;
    [containerView addSubview:toViewControllerImageView];
    
    [UIView animateWithDuration:0.5f animations:^{
                         fromViewControllerImageView.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5f animations:^{
                             toViewControllerImageView.alpha = 1.0f;
                         } completion:^(BOOL finished) {
                             [containerView addSubview:toViewController.view];
                             [UIView animateWithDuration:0.5f animations:^{
                                 fromViewControllerImageView.alpha = 0.0f;
                             } completion:^(BOOL finished) {
                                 [UIView animateWithDuration:0.5f animations:^{
                                     toViewControllerImageView.alpha = 0.0f;
                                 } completion:^(BOOL finished) {
                                     [transitionContext completeTransition:YES];
                                 }];
                             }];
                         }];
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

@end
