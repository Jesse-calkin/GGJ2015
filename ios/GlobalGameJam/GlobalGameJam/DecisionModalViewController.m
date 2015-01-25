//
//  DecisionModalViewController.m
//  GlobalGameJam
//
//  Created by Nick Dobos on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "DecisionModalViewController.h"
#import "GGJDecisionPoint.h"
#import "GGJDecisionPointChoice.h"
#import "GGJGameStateManager.h"

@interface DecisionModalViewController ()


@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UILabel *questionTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *topButton;

@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@property (strong, nonatomic) GGJDecisionPoint *decisionPoint;

@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIView *resultsBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@end

@implementation DecisionModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultView.hidden = YES;
    self.resultsBackgroundView.hidden = YES;

    self.modalView.layer.cornerRadius = 5.0f;
    self.modalView.layer.borderWidth = 1.0f;
    self.modalView.layer.borderColor = [UIColor yellowColor].CGColor;
    
    self.resultView.layer.cornerRadius = 5.0f;
    self.resultView.layer.borderWidth = 1.0f;
    self.resultView.layer.borderColor = [UIColor yellowColor].CGColor;
    
    self.topButton.layer.cornerRadius = 3.0f;
    self.topButton.layer.borderWidth = 1.0f;
    self.topButton.layer.borderColor = [UIColor yellowColor].CGColor;
    self.topButton.titleLabel.numberOfLines = 0;
    self.bottomButton.layer.cornerRadius = 3.0f;
    self.bottomButton.layer.borderWidth = 1.0f;
    self.bottomButton.titleLabel.numberOfLines = 0;
    self.bottomButton.layer.borderColor = [UIColor yellowColor].CGColor;
    
    self.continueButton.layer.cornerRadius = 3.0f;
    self.continueButton.layer.borderWidth = 1.0f;
    self.continueButton.titleLabel.numberOfLines = 0;
    self.continueButton.layer.borderColor = [UIColor yellowColor].CGColor;
}


- (void)configureWithDecisionPoint:(GGJDecisionPoint *)decisionPoint
{
    self.decisionPoint = decisionPoint;
    
    self.questionTextLabel.text = decisionPoint.promptText;
    [self.topButton setTitle:decisionPoint.choices[0] forState:UIControlStateNormal];
    [self.bottomButton setTitle:decisionPoint.choices[1] forState:UIControlStateNormal];
}

- (IBAction)topButtonPressed:(UIButton *)sender
{
    [[GGJGameStateManager sharedInstance] handleDecisionPointChoice:self.decisionPoint.choices[0]];
    
    self.resultView.hidden = NO;
    self.resultView.hidden = NO;
}


- (IBAction)bottomButtonPressed:(UIButton *)sender
{
    [[GGJGameStateManager sharedInstance] handleDecisionPointChoice:self.decisionPoint.choices[1]];
    
    self.resultView.hidden = NO;
    self.resultView.hidden = NO;
}


- (IBAction)continueButton:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
