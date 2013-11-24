//
//  AllShields.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/24/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "AllShields.h"

#define MAX_SHIELD_LEVEL 5

@interface AllShields ()

@property (nonatomic) int currentShieldLevel;

@end

@implementation AllShields

static AllShields *_allShieldsSingleton = nil;

+(AllShields *)allShieldsSingleton
{
    if (!_allShieldsSingleton) {
        _allShieldsSingleton = [[AllShields alloc] init];
    }
    return _allShieldsSingleton;
}

- (id) init {
    [self restoreShieldLevel];
    if (_currentShieldLevel == 0) {
        _currentShieldLevel = 1;
    }
    
    return self;
}



- (int) getCurrentShieldLevel
{
    return _currentShieldLevel;
}

- (int) getShieldTime
{
    NSDictionary *tempDict = [self getShieldDetails:_currentShieldLevel];
    int time = [[tempDict objectForKey:@"time"] integerValue];
    return time;
}


- (int) getShieldRecuperation
{
    NSDictionary *tempDict = [self getShieldDetails:_currentShieldLevel];
    int reg = [[tempDict objectForKey:@"regeneration"] integerValue];
    return reg;
}

- (void) updateShieldLevel
{
    _currentShieldLevel = MIN(_currentShieldLevel+1, MAX_SHIELD_LEVEL);
    [self saveShieldLevel];
}

- (BOOL) shieldLevelCanBeUpdated
{
    if (_currentShieldLevel < MAX_SHIELD_LEVEL) {
        return YES;
    } else {
        return NO;
    }
}

//----------------------------------------------------------
// Helper functions
//----------------------------------------------------------
- (NSDictionary*) getShieldDetails:(int)shield
{
    NSDictionary *shieldDetails = [[NSDictionary alloc] init];
    switch (shield) {
        case 1:
            shieldDetails = @{@"time": [NSNumber numberWithInt:4], @"regeneration": [NSNumber numberWithInt:30]};
            break;
        case 2:
            shieldDetails = @{@"time": [NSNumber numberWithInt:6], @"regeneration": [NSNumber numberWithInt:28]};
            break;
        case 3:
            shieldDetails = @{@"time": [NSNumber numberWithInt:8], @"regeneration": [NSNumber numberWithInt:26]};
            break;
        case 4:
            shieldDetails = @{@"time": [NSNumber numberWithInt:10], @"regeneration": [NSNumber numberWithInt:24]};
            break;
        case 5:
            shieldDetails = @{@"time": [NSNumber numberWithInt:12], @"regeneration": [NSNumber numberWithInt:22]};
            break;
            
        default:
            break;
    }
    
    return shieldDetails;
}

//----------------------------------------------------------
// Restoring the highscore manager from NSUserdefaults
//----------------------------------------------------------
- (void)restoreShieldLevel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int shieldLevel = [[defaults objectForKey:@"shieldLevel"] integerValue];
    _currentShieldLevel = shieldLevel;
}

//----------------------------------------------------------
// Saving the highscore manager to NSUserdefaults
//----------------------------------------------------------
- (void)saveShieldLevel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:_currentShieldLevel] forKey:@"shieldLevel"];
    [defaults synchronize];
}

@end
