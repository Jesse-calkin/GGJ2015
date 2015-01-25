//
//  GGJDecisionPoint.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScriptPoint.h"

@interface GGJDecisionPoint : NSObject <ScriptPoint>

@property (nonatomic) NSArray *choices;
@property (nonatomic,copy) NSString *promptText;

//  <ScriptPoint>
@property (assign, nonatomic) BOOL handled;
@property (assign, nonatomic) NSTimeInterval scheduledTime;


@end
