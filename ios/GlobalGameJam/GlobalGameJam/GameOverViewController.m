//
//  GameOverViewController.m
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/25/15.
//  
//

#import "GameOverViewController.h"
#import "GGJGameStateManager.h"

@interface GameOverViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation GameOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scoreLabel.text = [NSString stringWithFormat:@"SCORE: %d", [[GGJGameStateManager sharedInstance] score]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
