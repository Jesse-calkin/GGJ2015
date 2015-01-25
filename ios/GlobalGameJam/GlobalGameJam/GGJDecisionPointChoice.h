//
//  GGJDecisionPointChoice.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  Copyright (c) 2015 shoshinboogie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGJDecisionPointChoice : NSObject

@property (nonatomic, copy) NSString *optionText;
@property (nonatomic, copy) NSString *resultText;
@property (nonatomic,getter=isCorrect) BOOL correct;

@end
