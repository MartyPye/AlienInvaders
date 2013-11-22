//
//  LevelManager.m
//  AlienInvaders
//
//  Created by Marty Pye on 22/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "LevelManager.h"

@interface LevelManager() {
    NSMutableArray *levels;
}

+ (LevelManager*) sharedLevelManager;

@end



@implementation LevelManager

- (id) init;
{
    self = [super init];
    if (self != nil) {
        levels = [[NSMutableArray alloc] init];
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

@end
