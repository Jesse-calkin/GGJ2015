//
//  PlanningScene.m
//  GlobalGameJam
//
//  Created by Nick Dobos on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "PlanningScene.h"

@interface PlanningScene ()

@property NSMutableArray *lines;
@property UIImageView *imageView;
@property UILabel *titleLabel;

@property NSMutableArray *finishedImages;

@property NSArray *roundTimes;
@property NSTimeInterval startTime;
@property NSInteger currentRound;

@end

@implementation PlanningScene


- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    self.lines = [NSMutableArray array];
    self.finishedImages = [NSMutableArray array];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(self.view.center.x - 500, self.view.center.y - 400, 1000, 200);
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:44.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.imageView addSubview:self.titleLabel];

    NSTimeInterval round1Time = 15;
    NSTimeInterval round2Time = round1Time + 15;
    NSTimeInterval round3Time = round2Time + 15;
    self.roundTimes = @[@(round1Time), @(round2Time), @(round3Time)];
    
    self.startTime = 0;
    [self setRound:0];
    
}


- (void)update:(NSTimeInterval)currentTime
{
    if (self.currentRound >= self.roundTimes.count) {
        [self completeGame];
        return;
    }
    
    if (self.startTime == 0) {
        self.startTime = currentTime;
    }
    
    NSTimeInterval timeSinceWeStarted = currentTime - self.startTime;
    
    if (timeSinceWeStarted > [self.roundTimes[self.currentRound] doubleValue]) {
        [self setRound:self.currentRound + 1];
    }
    
    [self drawLines];
}


- (void)setRound:(NSInteger)newRound;
{
    self.currentRound = newRound;

    self.titleLabel.alpha = 1.0f;
    
    if (self.imageView.image != nil) {
        [self.finishedImages addObject:self.imageView.image];
    }
    
    [self.lines removeAllObjects];
    
    if (newRound == 0) {
        self.titleLabel.text = @"QUICK! WE NEED A GAME TITLE";
    }
    else if(newRound == 1) {
        self.titleLabel.text = @"NOW WE NEED A MAIN CHARACTER";
    }
    else if(newRound == 2) {
        self.titleLabel.text = @"NOW A KICKASS GAME MECHANIC";
    }
    
    [UIView animateWithDuration:5.0f animations:^{
        self.titleLabel.alpha = 0.0f;
    }];
}


- (void)completeGame
{
    self.titleLabel.alpha = 1.0f;
    self.titleLabel.text = @"LOOKS GOOD, NOW MAKE THAT SHIT";
    
    //DismissViewController or something?!?!
}


- (void)drawLines
{
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 20.0f);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    for (NSInteger i = 0; i < self.lines.count; i++) {
        NSMutableArray *line = [self.lines objectAtIndex:i];
            CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        for (NSInteger j = 0; j < line.count; j++) {
            CGPoint point = [[line objectAtIndex:j] CGPointValue];
            CGPoint convertedPoint = [self.scene convertPointToView:point];
            
            if (j== 0) {
                CGContextMoveToPoint(context, convertedPoint.x, convertedPoint.y);
            }
            else {
                CGContextAddLineToPoint(context, convertedPoint.x, convertedPoint.y);
            }
        }
        CGContextStrokePath(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    self.imageView.image = image;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInNode:self.scene];
    NSMutableArray *line = [NSMutableArray arrayWithObject:[NSValue valueWithCGPoint:touchPoint]];
    [self.lines addObject:line];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInNode:self.scene];
    NSMutableArray *line = [self.lines lastObject];
    [line addObject:[NSValue valueWithCGPoint:touchPoint]];
}


@end
