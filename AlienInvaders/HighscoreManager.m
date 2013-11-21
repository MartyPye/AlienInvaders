//
//  HighscoreManager.m
//  AlienInvaders
//
//  Created by Marty on 11/20/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "HighscoreManager.h"
#import "Highscore.h"

@interface HighscoreManager() {
//    NSMutableArray *highscores;
}

@property (nonatomic) NSMutableArray *highscores;

@end

@implementation HighscoreManager

- (id) init;
{
    self = [super init];
    if (self != Nil) {
        self.highscores = [[NSMutableArray alloc] init];
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
    [self.highscores addObject:newHighscore];
    
    // sort in descending order
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.highscores = [NSMutableArray arrayWithArray:[self.highscores sortedArrayUsingDescriptors:sortDescriptors]];
}


// ----------------------------------------------------------------------------------------------------
// Returns the name of the player at a certain position;
// ----------------------------------------------------------------------------------------------------
- (NSString*) nameOfPlayerAtPosition:(NSUInteger)thePosition;
{
    NSString *result = @"";
    if (thePosition < self.highscores.count) {
        result = [[self.highscores objectAtIndex:thePosition] name];
    }
    return result;
}


// ----------------------------------------------------------------------------------------------------
// Returns the score of the player at a certain position;
// ----------------------------------------------------------------------------------------------------
- (NSNumber*) scoreOfPlayerAtPosition:(NSUInteger)thePosition;
{
    NSNumber *result = [[NSNumber alloc] init];
    if (thePosition < self.highscores.count) {
        result = [[self.highscores objectAtIndex:thePosition] score];
    }
    return result;
}


// ----------------------------------------------------------------------------------------------------
// Returns the total amount of highscores
// ----------------------------------------------------------------------------------------------------
- (NSUInteger) totalAmountOfHighscores;
{
    return self.highscores.count;
}


// ----------------------------------------------------------------------------------------------------
// Make NSCoding compliant
// ----------------------------------------------------------------------------------------------------
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.highscores forKey:@"highscores"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.highscores = [decoder decodeObjectForKey:@"highscores"];
    }
    return self;
}

@end
