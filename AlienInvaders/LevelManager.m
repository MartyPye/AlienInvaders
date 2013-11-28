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
//        Level* level1 = [[Level alloc] initWithIndex:0 andName:@"Level 1"];
//        Level* level2 = [[Level alloc] initWithIndex:1 andName:@"Level 2"];
//        Level* level3 = [[Level alloc] initWithIndex:2 andName:@"Level 3"];
//        
//        [levels addObject:level1];
//        [levels addObject:level2];
//        [levels addObject:level3];
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

@end
