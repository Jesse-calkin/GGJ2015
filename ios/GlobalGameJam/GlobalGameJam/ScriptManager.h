//
//  ScriptManager.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  
//

#import <Foundation/Foundation.h>
#import "ScriptPoint.h"

@interface ScriptManager : NSObject

+ (NSArray *)allScriptPoints;
+ (id<ScriptPoint>)currentScriptPoint;

@end
