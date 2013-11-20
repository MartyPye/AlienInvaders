//
//  HighscoreManager.m
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "HighscoreManager.h"

@interface HighscoreManager() {
    NSMutableArray *highscores;
}

@end

@implementation HighscoreManager

- (id) init;
{
    self = [super init];
    if (self != Nil) {
        highscores = [[NSMutableArray alloc] init];
    }
    return self;
}


// ----------------------------------------------------------------------------------------------------
// Adds a highscore
// ----------------------------------------------------------------------------------------------------
- (void) addHighscore:(NSNumber *)theScore withName:(NSString *)theName;
{
    // add the highscore
    Highscore *newHighscore = [Highscore highscoreWithScore:theScore andName:theName];
    [highscores addObject:newHighscore];
    
    // sort in descending order
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    highscores = [NSMutableArray arrayWithArray:[highscores sortedArrayUsingDescriptors:sortDescriptors]];
}


// ----------------------------------------------------------------------------------------------------
// Returns the name of the player at a certain position;
// ----------------------------------------------------------------------------------------------------
- (NSString*) nameOfPlayerAtPosition:(NSUInteger)thePosition;
{
    NSString *result = @"";
    if (thePosition < highscores.count) {
        result = [[highscores objectAtIndex:thePosition] name];
    }
    return result;
}

@end
