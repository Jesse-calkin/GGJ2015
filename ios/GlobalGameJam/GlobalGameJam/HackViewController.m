//
//  HackViewController.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "HackViewController.h"

static NSInteger CharactersPerTap = 20;

@interface HackViewController ()
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) UIButton *lastButtonTapped;
@property (strong, nonatomic) NSString *fullString;
@property (assign, nonatomic) NSInteger numberOfTaps;
@end

@implementation HackViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = nil;
    
    [self clearButton:self.leftButton];
    [self clearButton:self.rightButton];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HackSceneText" ofType:nil];
    NSString *fullString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.fullString = fullString;
}

#pragma mark - Actions

- (IBAction)buttonTapped:(UIButton *)button {
    if (button != self.lastButtonTapped) {
        self.numberOfTaps++;
        NSString *currentString = [self currentString];
        self.label.text = currentString;
    }
}

#pragma mark - Private

- (NSString *)currentString {
    NSInteger currentLength = CharactersPerTap * self.numberOfTaps;
    NSUInteger maximumLength = self.fullString.length;
    NSUInteger length = currentLength;
    if (length > maximumLength) {
        length = maximumLength;
    }
    NSRange range = NSMakeRange(0, length);
    NSString *currentString = [self.fullString substringWithRange:range];
    return currentString;
}

- (void)clearButton:(UIButton *)button {
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:nil forState:UIControlStateNormal];
}

@end
