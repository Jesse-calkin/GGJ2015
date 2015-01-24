//
//  AppDelegate.h
//  GlobalGameJam
//
//  Created by jesse calkin on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGJTimeline;

#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) GGJTimeline *timeline;

@end

