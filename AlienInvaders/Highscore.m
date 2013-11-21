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


// ----------------------------------------------------------------------------------------------------
// Make NSCoding compliant
// ----------------------------------------------------------------------------------------------------
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.score forKey:@"score"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.score = [decoder decodeObjectForKey:@"score"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.date = [decoder decodeObjectForKey:@"date"];
    }
    return self;
}


@end
