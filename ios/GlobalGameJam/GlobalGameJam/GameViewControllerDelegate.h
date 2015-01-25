//
//  GameViewControllerDelegate.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

@protocol GameViewControllerDelegate <NSObject>
- (void)gameViewControllerFinished;
- (void)gameViewControllerFinishedWithContext:(id)context;
@end
