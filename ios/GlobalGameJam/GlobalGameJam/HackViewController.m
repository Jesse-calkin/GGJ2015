//
//  HackViewController.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "HackViewController.h"
#import "UIViewController+Additions.h"

static NSInteger CharactersPerTap = 40;

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
    
    [self populateFullString];
    [self initializeViews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat y = 0.0f;
    CGFloat halfWidth = self.view.frame.size.width / 2.0f;
    CGFloat height = self.view.frame.size.height;
    
    CGRect leftButtonFrame = self.leftButton.frame;
    leftButtonFrame.origin.x = 0.0f;
    leftButtonFrame.origin.y = y;
    leftButtonFrame.size.width = halfWidth;
    leftButtonFrame.size.height = height;
    self.leftButton.frame = leftButtonFrame;
    
    CGRect rightButtonFrame = self.rightButton.frame;
    rightButtonFrame.origin.x = halfWidth;
    rightButtonFrame.origin.y = y;
    rightButtonFrame.size.width = halfWidth;
    rightButtonFrame.size.height = height;
    self.rightButton.frame = rightButtonFrame;
}

#pragma mark - Actions

- (IBAction)buttonTapped:(UIButton *)button {
    if (button != self.lastButtonTapped) {
        self.lastButtonTapped = button;
        self.numberOfTaps++;
        [self updateLabel];
        [self winIfWeWon];
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

- (void)updateLabel {
    NSString *currentString = [self currentString];
    self.label.text = currentString;
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat maximumHeight = CGFLOAT_MAX;
    CGSize maximumSize = CGSizeMake(width, maximumHeight);
    CGSize textSize = [currentString sizeWithFont:self.label.font constrainedToSize:maximumSize lineBreakMode:self.label.lineBreakMode];
    CGFloat textHeight = textSize.height;
    
    CGRect labelFrame = self.label.frame;
    labelFrame.origin.y = 0.0f;
    if (textHeight > self.view.bounds.size.height) {
        labelFrame.origin.y = self.view.bounds.size.height - textHeight;
    }
    labelFrame.size.width = width;
    labelFrame.size.height = textSize.height;
    self.label.frame = labelFrame;
}

- (void)clearButton:(UIButton *)button {
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:nil forState:UIControlStateNormal];
}

- (void)populateFullString {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HackText" ofType:nil];
    NSString *fullString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.fullString = fullString;
}

- (void)initializeViews {
    [self clearButton:self.leftButton];
    [self clearButton:self.rightButton];
    [self updateLabel];
}

- (BOOL)gameIsFinished {
    NSString *currentString = [self currentString];
    BOOL gameIsFinished = [currentString isEqualToString:self.fullString];
    return gameIsFinished;
}

- (void)winIfWeWon {
    BOOL gameIsFinished = [self gameIsFinished];
    if (gameIsFinished) {
        [self.gameViewControllerDelegate gameViewControllerFinished:self];
    }
}

@end
