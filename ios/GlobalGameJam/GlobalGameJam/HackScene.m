//
//  HackScene.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "HackScene.h"

static NSInteger CharactersPerTap = 2;

@interface HackScene ()
@property (strong, nonatomic) NSString *fullString;
@property (assign, nonatomic) NSInteger numberOfTaps;
@property (strong, nonatomic) SKLabelNode *label;
@end

@implementation HackScene

-(void)didMoveToView:(SKView *)view {
    self.fullString = @"Lots of cool text goes right here.";
    
    self.label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    self.label.fontSize = 15;
    self.label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.label.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    [self addChild:self.label];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.numberOfTaps++;
    NSString *currentString = [self currentString];
    self.label.text = currentString;
}

#pragma mark - Private

- (NSString *)currentString {
    NSInteger currentLength = CharactersPerTap * self.numberOfTaps;
    NSUInteger maximumLength = self.fullString.length;
    NSUInteger length = currentLength;
    if (length > maximumLength) {
        length = maximumLength;
    }
    NSRange range = NSMakeRange(0, length);
    NSString *currentString = [self.fullString substringWithRange:range];
    return currentString;
}

@end
