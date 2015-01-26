//
//  GGJDecisionPointChoice.h
//  GlobalGameJam
//
//  Created by Carl Veazey on 1/24/15.
//  
//

#import <Foundation/Foundation.h>

@interface GGJDecisionPointChoice : NSObject

@property (nonatomic, copy) NSString *optionText;
@property (nonatomic, copy) NSString *resultText;
@property (nonatomic,getter=isCorrect) BOOL correct;

@end
