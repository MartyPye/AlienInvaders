//
//  LevelManager.m
//  AlienInvaders
//
//  Created by Marty Pye on 22/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "LevelManager.h"
#import "Level.h"

@interface LevelManager() {
    NSMutableArray *levels;
    Level *currentLevel;
}

+ (LevelManager*) sharedLevelManager;

@end



@implementation LevelManager

- (id) init;
{
    self = [super init];
    if (self != nil) {
        levels = [[NSMutableArray alloc] init];
        
        //init the dictionary that holds the points we collected in the different levels
        _pointsCollectedInLevel = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [self totalAmountOfLevels]; i++) {
            NSLog(@"level");
            [_pointsCollectedInLevel setObject:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"%d",[[NSNumber numberWithInt:i] integerValue]]];
        }
        
        [self restorePointsCollectedInLevel];
    }
    
    return self;
}


// ----------------------------------------------------------------------------------------------------
// Singleton
// ----------------------------------------------------------------------------------------------------
+ (LevelManager*) sharedLevelManager;
{
    static LevelManager *sharedLevelManager;
    
    @synchronized(self)
    {
        if (!sharedLevelManager) {
            sharedLevelManager = [[LevelManager alloc] init];
        }
        
        return sharedLevelManager;
    }
}


// ----------------------------------------------------------------------------------------------------
// Returns the total amount of levels.
// ----------------------------------------------------------------------------------------------------
- (NSUInteger) totalAmountOfLevels;
{
    return levels.count;
}


// called when the game scene is setup
- (void) setupCurrentLevel;
{
    if (currentLevel == nil)
        currentLevel = [[Level alloc] initWithIndex:self.currentLevelIndex andScene:self.scene];
    else {
        [currentLevel setLevelIndex:self.currentLevelIndex];
        [currentLevel setScene:self.scene];
    }
}

- (void) pauseLevel;
{
    [currentLevel pause];
}

- (void) finishLevel;
{
    [currentLevel finish];
}


- (void) realizedNumberOfPoints:(int)points
{
    if ([[_pointsCollectedInLevel valueForKey:[NSString stringWithFormat:@"%d",[[NSNumber numberWithInt:_currentLevelIndex] integerValue]]] integerValue] < points) {
        [_pointsCollectedInLevel setObject:[NSNumber numberWithInt:points] forKey:[NSString stringWithFormat:@"%d",[[NSNumber numberWithInt:_currentLevelIndex] integerValue]]];
        [self savePointsCollected];
    }
}


//----------------------------------------------------------
// Restoring the _pointsCollectedInLevel from NSUserdefaults
//----------------------------------------------------------
- (void)restorePointsCollectedInLevel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *tempDict = [defaults objectForKey:@"pointsCollectedInLevel"];
    if (tempDict != nil) {
        _pointsCollectedInLevel = [NSMutableDictionary dictionaryWithDictionary:tempDict];
    }
}

//----------------------------------------------------------
// Saving the _pointsCollectedInLevel to NSUserdefaults
//----------------------------------------------------------
- (void)savePointsCollected
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_pointsCollectedInLevel forKey:@"pointsCollectedInLevel"];
    [defaults synchronize];
}

@end
