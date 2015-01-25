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

@interface MainViewController () <GameViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *gameTitleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainCharacterImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gameMechanicImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) BOOL canDisplayDecisionPoint;



@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleClockTick) name:GGJClockTickElapsedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleScoreChanged) name:GGJScoreChangedNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.canDisplayDecisionPoint = YES;
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
    
    [self rollForDecisionsPoint];
}

- (void)handleScoreChanged
{
    self.scoreLabel.text = [NSString stringWithFormat:@"SCORE: %d", [GGJGameStateManager sharedInstance].score];
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
        UIViewController *viewController = [[viewControllerClass alloc] init];
        viewController.gameViewControllerDelegate = self;
        
        self.canDisplayDecisionPoint = NO;
        
        [self switchToViewController:viewController completion:nil];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *pickerItem = [self pickerItemAtIndex:row];
    return pickerItem;
}

#pragma mark - Private

- (NSArray *)pickerItems {
    NSArray *pickerItems = @[@"", @"CoffeeViewController", @"HackViewController", @"PlanningViewController"];
    return pickerItems;
}

- (NSString *)pickerItemAtIndex:(NSInteger)index {
    NSArray *pickerItems = [self pickerItems];
    NSString *pickerItem = pickerItems[index];
    return pickerItem;
}

- (void)rollForDecisionsPoint
{
    if (self.canDisplayDecisionPoint) {
        if (arc4random_uniform(20) == 1) {
            DecisionModalViewController *modalViewController = [[DecisionModalViewController alloc] init];
            [modalViewController configureWithDecisionPoint:[GGJDecisionPoint randomDecisionPoint]];
            modalViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [self presentViewController:modalViewController animated:YES completion:nil];
        }
    }
}

#pragma mark - <GameViewControllerDelegate>

- (void)gameViewControllerFinished:(UIViewController *)gameViewController {
    if ([gameViewController isKindOfClass:[HackViewController class]]) {
        [gameViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)gameViewController:(UIViewController *)gameViewController finishedWithContext:(id)context {
    if ([gameViewController isKindOfClass:[PlanningViewController class]]) {
        NSArray *images = (NSArray *)context;
        self.gameTitleImageView.image = [images objectAtIndex:0];
        self.mainCharacterImageView.image = [images objectAtIndex:1];
        self.gameMechanicImageView.image = [images objectAtIndex:2];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if ([gameViewController isKindOfClass:[CoffeeViewController class]]) {
        BOOL didWin = [context boolValue];
        if (didWin) {
            [gameViewController dismissViewControllerAnimated:YES completion:^{
                NSLog(@"How funky is your chicken?");
            }];
        }
    }
}

@end
