//
//  HackScene.m
//  GlobalGameJam
//
//  Created by Chris Weathers on 1/23/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import "HackScene.h"

static NSInteger CharactersPerTap = 20;

@interface HackScene ()
@property (strong, nonatomic) NSString *fullString;
@property (assign, nonatomic) NSInteger numberOfTaps;
@property (strong, nonatomic) UILabel *label;
@end

@implementation HackScene

-(void)didMoveToView:(SKView *)view {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HackSceneText" ofType:nil];
    NSString *fullString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.fullString = fullString;
    
    CGRect frame = view.bounds;
    self.label = [[UILabel alloc] initWithFrame:frame];
    self.label.numberOfLines = 0;
    [view addSubview:self.label];
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
