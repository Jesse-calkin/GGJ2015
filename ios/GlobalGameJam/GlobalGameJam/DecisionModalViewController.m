//
//  DecisionModalViewController.m
//  GlobalGameJam
//
//  Created by Nick Dobos on 1/24/15.
//  
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
@property (weak, nonatomic) IBOutlet UIView *unityView;

@end

@implementation DecisionModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultView.hidden = YES;
    self.resultsBackgroundView.hidden = YES;
    self.unityView.hidden = YES;

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
    self.topButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomButton.layer.cornerRadius = 3.0f;
    self.bottomButton.layer.borderWidth = 1.0f;
    self.bottomButton.titleLabel.numberOfLines = 0;
    self.bottomButton.layer.borderColor = [UIColor yellowColor].CGColor;
    self.bottomButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.continueButton.layer.cornerRadius = 3.0f;
    self.continueButton.layer.borderWidth = 1.0f;
    self.continueButton.titleLabel.numberOfLines = 0;
    self.continueButton.layer.borderColor = [UIColor yellowColor].CGColor;
    
    [self configureWithDecisionPoint:self.decisionPoint];
}


- (void)configureWithDecisionPoint:(GGJDecisionPoint *)decisionPoint
{
    self.decisionPoint = decisionPoint;
    
    self.questionTextLabel.text = decisionPoint.promptText;
    
    GGJDecisionPointChoice *choice1 = decisionPoint.choices[0];
    GGJDecisionPointChoice *choice2 = decisionPoint.choices[1];
    
    [self.topButton setTitle:choice1.optionText forState:UIControlStateNormal];
    [self.bottomButton setTitle:choice2.optionText forState:UIControlStateNormal];
}

- (IBAction)topButtonPressed:(UIButton *)sender
{
    GGJDecisionPointChoice *choice1 = self.decisionPoint.choices[0];
    [[GGJGameStateManager sharedInstance] handleDecisionPointChoice:choice1];
    
    self.resultLabel.text = choice1.resultText;
    
    if ([choice1.resultText isEqualToString:@"GREY SCREEN"]) {
        [self displayAndHideUnityView];
    }
    
    self.resultView.hidden = NO;
    self.resultsBackgroundView.hidden = NO;
}


- (IBAction)bottomButtonPressed:(UIButton *)sender
{
    GGJDecisionPointChoice *choice2 = self.decisionPoint.choices[1];
    [[GGJGameStateManager sharedInstance] handleDecisionPointChoice:choice2];
    
    self.resultLabel.text = choice2.resultText;
    
    if ([choice2.resultText isEqualToString:@"GREY SCREEN"]) {
        [self displayAndHideUnityView];
    }
    
    self.resultView.hidden = NO;
    self.resultsBackgroundView.hidden = NO;
}


- (IBAction)continueButton:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)displayAndHideUnityView
{
    self.unityView.hidden = NO;
    
    [UIView animateWithDuration:5.0f delay:5.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.unityView.alpha = 0.0f;
    }
    completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


@end
