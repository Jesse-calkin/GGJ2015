//
//  GameViewControllerDelegate.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  
//

@protocol GameViewControllerDelegate <NSObject>
- (void)gameViewControllerFinished:(UIViewController *)gameViewController;
- (void)gameViewController:(UIViewController *)gameViewController finishedWithContext:(id)context;
@end
