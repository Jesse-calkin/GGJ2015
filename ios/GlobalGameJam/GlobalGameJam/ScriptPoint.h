//
//  ScriptPoint.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

@protocol ScriptPoint <NSObject>
@property (assign, nonatomic) BOOL handled;
@property (assign, nonatomic) NSTimeInterval scheduledTime;
@end
