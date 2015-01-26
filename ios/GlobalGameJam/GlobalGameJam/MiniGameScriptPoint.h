//
//  MiniGameScriptPoint.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  
//

#import <Foundation/Foundation.h>
#import "ScriptPoint.h"

@interface MiniGameScriptPoint : NSObject <ScriptPoint>

@property (assign, nonatomic) NSTimeInterval duration;
@property (strong, nonatomic) NSString *viewControllerClassName;

//  <ScriptPoint>
@property (assign, nonatomic) BOOL handled;
@property (assign, nonatomic) NSTimeInterval scheduledTime;

- (Class)viewControllerClass;

@end
