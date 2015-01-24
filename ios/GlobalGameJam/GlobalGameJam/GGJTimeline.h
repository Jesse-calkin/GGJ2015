//
//  GGJTimeline.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GGJTimelineStage;

@interface GGJTimeline : NSObject

@property (nonatomic) NSArray *timelineStages;
@property (nonatomic) GGJTimelineStage *targetStage;
@property (nonatomic) GGJTimelineStage *playerStage;

@end
