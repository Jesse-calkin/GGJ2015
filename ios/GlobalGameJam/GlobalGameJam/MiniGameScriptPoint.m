//
//  MiniGameScriptPoint.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "MiniGameScriptPoint.h"

@implementation MiniGameScriptPoint

- (Class)viewControllerClass
{
    Class viewControllerClass = NSClassFromString(self.viewControllerClassName);
    return viewControllerClass;
}

@end
