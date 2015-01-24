//
//  MainViewController.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+Additions.h"

@interface MainViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation MainViewController

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
        [self switchToViewController:viewController completion:nil];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *pickerItem = [self pickerItemAtIndex:row];
    return pickerItem;
}

#pragma mark - Private

- (void)switchToViewControllerOfClass:(Class)viewControllerClass {
    UIViewController *viewController = [[viewControllerClass alloc] init];
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

@end
