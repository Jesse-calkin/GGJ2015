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
#import "PlanningViewController.h"
#import "UIViewController+Additions.h"

@interface MainViewController () <GameViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleClockTick) name:GGJClockTickElapsedNotification object:nil];
}

- (void)handleClockTick
{
    NSUInteger elapsedPercentage = [[[GGJGameStateManager sharedInstance] clock] percentageTimeElapsed];
    float progress = (float)elapsedPercentage / 100;
    [self.progressView setProgress:progress animated:YES];
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

#pragma mark - <GameViewControllerDelegate>

- (void)gameViewControllerFinished:(UIViewController *)gameViewController {
    
}

- (void)gameViewController:(UIViewController *)gameViewController finishedWithContext:(id)context {
    if ([gameViewController isKindOfClass:[PlanningViewController class]]) {
        PlanningViewController *planningViewController = (PlanningViewController *)gameViewController;
        UIImage *image = (UIImage *)context;
        
        //  Nick does really awesome things here.
    }
}

@end
