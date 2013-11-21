//
//  Highscore.h
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Highscore : NSObject

@property(strong, nonatomic) NSNumber *score;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSDate *date;
// TODO: add level.

+ (Highscore*) highscoreWithScore:(NSNumber*)theScore andName:(NSString*)theName;

@end
