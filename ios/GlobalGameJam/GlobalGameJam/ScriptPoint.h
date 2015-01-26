//
//  ScriptPoint.h
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/24/15.
//  
//

@protocol ScriptPoint <NSObject>
@property (assign, nonatomic) BOOL handled;
@property (assign, nonatomic) NSTimeInterval scheduledTime;
@end
