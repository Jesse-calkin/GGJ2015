//
//  MainViewController.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+Additions.h"
#import "GGJClock.h"
#import "GGJGameStateManager.h"
#import "HackViewController.h"
#import "PlanningViewController.h"
#import "CoffeeViewController.h"
#import "UIViewController+Additions.h"
#import "DecisionModalViewController.h"
#import "GGJDecisionPoint.h"
#import "ScriptManager.h"
#import "MiniGameScriptPoint.h"
#import "GameOverViewController.h"

@interface MainViewController () <GameViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

//  Background image stuff.
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *backgroundViews;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *titleImageViews;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *characterImageViews;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *mechanicImageViews;
@property (strong, nonatomic) IBOutlet UIView *backgroundViewsContainerView;
@property (assign, nonatomic) NSInteger currentBackgroundViewIndex;

@end

@implementation MainViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleClockTick) name:GGJClockTickElapsedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleScoreChanged) name:GGJScoreChangedNotification object:nil];
    
    [self setUpBackgroundViews];
    [self updateBackgroundViewAnimated:NO];
}

#pragma mark - Notification Handlers

- (void)handleClockTick
{
    NSUInteger elapsedPercentage = [[[GGJGameStateManager sharedInstance] clock] percentageTimeElapsed];
    float progress = (float)elapsedPercentage / 100;

    NSTimeInterval tickLength = [[[GGJGameStateManager sharedInstance] clock] tickLength];
    [UIView animateWithDuration:tickLength delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [self.progressView setProgress:progress animated:YES];
    } completion:nil];
    
    id<ScriptPoint> currentScriptPoint = [ScriptManager currentScriptPoint];
    if (currentScriptPoint != nil) {
        if (self.presentedViewController == nil) {
            currentScriptPoint.handled = YES;
            
            if ([currentScriptPoint isKindOfClass:[GGJDecisionPoint class]]) {
                GGJDecisionPoint *decisionPoint = (GGJDecisionPoint *)currentScriptPoint;
                [self presentDecisionPoint:decisionPoint];
            }
            else if ([currentScriptPoint isKindOfClass:[MiniGameScriptPoint class]]) {
                MiniGameScriptPoint *miniGameScriptPoint = (MiniGameScriptPoint *)currentScriptPoint;
                [self switchToViewControllerOfClass:miniGameScriptPoint.viewControllerClass];
            }
        }
    }
    
    [self updateBackgroundViewAnimated:YES];
}

- (void)handleScoreChanged
{
    self.scoreLabel.text = [NSString stringWithFormat:@"GAME AWESOMENESS SCORE: %d", [GGJGameStateManager sharedInstance].score];
}

#pragma mark - Actions

- (IBAction)loadButtonTapped {
    CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, 500.0f);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:frame];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    NSInteger numberOfComponents = 1;
    return numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *pickerItems = [self pickerItems];
    NSInteger numberOfPickerItems = [pickerItems count];
    return numberOfPickerItems;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *pickerItem = [self pickerItemAtIndex:row];
    Class viewControllerClass = NSClassFromString(pickerItem);
    if (viewControllerClass != nil) {
        [self switchToViewControllerOfClass:viewControllerClass];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *pickerItem = [self pickerItemAtIndex:row];
    return pickerItem;
}

#pragma mark - Private

- (void)switchToViewControllerOfClass:(Class)class {
    UIViewController *viewController = [[class alloc] init];
    viewController.gameViewControllerDelegate = self;
    [self switchToViewController:viewController completion:nil];
}

- (NSArray *)pickerItems {
    NSArray *pickerItems = @[@"", @"CoffeeViewController", @"HackViewController", @"PlanningViewController"];
    return pickerItems;
}

- (NSString *)pickerItemAtIndex:(NSInteger)index {
    NSArray *pickerItems = [self pickerItems];
    NSString *pickerItem = pickerItems[index];
    return pickerItem;
}

- (void)presentDecisionPoint:(GGJDecisionPoint *)decisionPoint {
    DecisionModalViewController *modalViewController = [[DecisionModalViewController alloc] init];
    [modalViewController configureWithDecisionPoint:decisionPoint];
    modalViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    modalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:modalViewController animated:YES completion:nil];
}

#pragma mark - <GameViewControllerDelegate>

- (void)gameViewControllerFinished:(UIViewController *)gameViewController {
    if ([gameViewController isKindOfClass:[HackViewController class]]) {
        [[GGJGameStateManager sharedInstance] handleMinigameWon:YES];
        [gameViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)gameViewController:(UIViewController *)gameViewController finishedWithContext:(id)context {
    if ([gameViewController isKindOfClass:[PlanningViewController class]]) {
        [[GGJGameStateManager sharedInstance] handleMinigameWon:YES];
        NSArray *images = (NSArray *)context;
        [self applyImage:images[0] toImageViews:self.titleImageViews];
        [self applyImage:images[1] toImageViews:self.characterImageViews];
        [self applyImage:images[2] toImageViews:self.mechanicImageViews];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if ([gameViewController isKindOfClass:[CoffeeViewController class]]) {
        BOOL didWin = [context boolValue];
        [[GGJGameStateManager sharedInstance] handleMinigameWon:didWin];
        if (didWin) {
            [gameViewController dismissViewControllerAnimated:YES completion:^{
                NSLog(@"How funky is your chicken?");
            }];
        }
    }
}

#pragma mark - Background image stuff

- (void)applyImage:(UIImage *)image toImageViews:(NSArray *)imageViews {
    [imageViews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger index, BOOL *stop) {
        imageView.image = image;
    }];
}

- (NSInteger)backgroundViewIndexForProgress:(CGFloat)progress {
    NSInteger index = 0;
    
    if (progress < .03f) {
        index = 2;
    }
    if (progress < .02f) {
        index = 1;
    }
    if (progress < .01f) {
        index = 0;
    }
    
    return index;
}

- (UIView *)backgroundViewForProgress:(CGFloat)progress {
    NSInteger backgroundViewIndex = [self backgroundViewIndexForProgress:progress];
    UIView *backgroundView = self.backgroundViews[backgroundViewIndex];
    return backgroundView;
}

- (void)showBackgroundView:(UIView *)backgroundView animated:(BOOL)animated {
    if (backgroundView.alpha == 1.0f) {
        return;
    }
    
    [backgroundView.superview bringSubviewToFront:backgroundView];
    
    NSTimeInterval duration = (animated ? 1.0f : 0.0f);
    [UIView animateWithDuration:duration animations:^{
        backgroundView.alpha = 1.0f;
    }];
}

- (void)updateBackgroundViewAnimated:(BOOL)animated {
    NSUInteger elapsedPercentage = [[[GGJGameStateManager sharedInstance] clock] percentageTimeElapsed];
    CGFloat progress = (CGFloat)elapsedPercentage / 100.0f;
    UIView *backgroundView = [self backgroundViewForProgress:progress];
    [self showBackgroundView:backgroundView animated:animated];
}

- (void)setUpBackgroundViews {
    [self.backgroundViews enumerateObjectsUsingBlock:^(UIView *backgroundView, NSUInteger index, BOOL *stop) {
        [self.backgroundViewsContainerView addSubview:backgroundView];
        backgroundView.alpha = 0.0f;
    }];
}

@end
