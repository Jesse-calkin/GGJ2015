//
//  MainViewController.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "MainViewController.h"
#import "CoffeeViewController.h"
#import "HackViewController.h"
#import "PlanningViewController.h"
#import "UIViewController+Additions.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - Actions

- (IBAction)coffeeButtonTapped {
    [self switchToViewControllerOfClass:[CoffeeViewController class]];
}

- (IBAction)hackButtonTapped {
    [self switchToViewControllerOfClass:[HackViewController class]];
}

- (IBAction)planningButtonTapped {
    [self switchToViewControllerOfClass:[PlanningViewController class]];
}

#pragma mark - Private

- (void)switchToViewControllerOfClass:(Class)viewControllerClass {
    UIViewController *viewController = [[viewControllerClass alloc] init];
    [self switchToViewController:viewController completion:nil];
}

@end
