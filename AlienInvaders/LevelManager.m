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
        
        //init the array that says how many coins you need to receive the different stars
        [self initPointsToStars];
        
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


- (void) initPointsToStars
{
    _pointsToStarsDict = [[NSMutableDictionary alloc] init];
    [_pointsToStarsDict setValue:@[@10,@20,@30] forKey:@"0"];
    [_pointsToStarsDict setValue:@[@50,@100,@150] forKey:@"1"];
    [_pointsToStarsDict setValue:@[@50,@100,@150] forKey:@"2"];
}

//----------------------------------------------------------
// Updating a level with the points collected
//----------------------------------------------------------
- (void) realizedNumberOfPoints:(int)points
{
    //Adding the level to the dictionary if it does not exist already
    if ([self getPointsForLevelIndex:_currentLevelIndex] == 0) {
        [_pointsCollectedInLevel setObject:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"%d",(int)_currentLevelIndex]];
    }
    
    //updating the dictionary if the points collected > points so far
    int pointsSoFar = [[_pointsCollectedInLevel valueForKey:[NSString stringWithFormat:@"%d",(int)_currentLevelIndex]] intValue];
    if ( pointsSoFar <= points)
    {
        //When we get a new highscore, we add the difference of the coins to the coins we can spend
        [[CoinManager sharedCoinManager] addCoinsThatCanBeSpent:points-pointsSoFar];
        
        //Set the new highscore in the dictionary
        [_pointsCollectedInLevel setObject:[NSNumber numberWithInt:points] forKey:[NSString stringWithFormat:@"%d",(int)_currentLevelIndex]];
        [self savePointsCollected];
    }
}


//----------------------------------------------------------
// Returns the number of points collected in a level
//----------------------------------------------------------
- (int) getPointsForLevelIndex:(NSInteger)levelIndex
{
    NSNumber *tempNumber = [_pointsCollectedInLevel objectForKey:[NSString stringWithFormat:@"%d",(int)levelIndex]];
    if (tempNumber == nil) {
        return 0;
    } else {
        return [tempNumber intValue];
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
