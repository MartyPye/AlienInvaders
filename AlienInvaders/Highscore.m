//
//  Highscore.m
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Highscore.h"

@interface Highscore() {
    
}

@end

@implementation Highscore


- (id)initWithScore:(NSNumber*)theScore andName:(NSString*)theName;
{
	self = [super init];
	if (self != nil) {
        self.score = [NSNumber numberWithInt:[theScore integerValue]];
        self.name = [NSString stringWithFormat:@"%@", theName];
        self.date = [NSDate date];
        
	}
	return self;
}


// ----------------------------------------------------------------------------------------------------
// Convenience method to create highscore
// ----------------------------------------------------------------------------------------------------
+ (Highscore*) highscoreWithScore:(NSNumber*)theScore andName:(NSString*)theName;
{
    Highscore *highscore = [[Highscore alloc] initWithScore:theScore andName:theName];
    return  highscore;
}

@end
