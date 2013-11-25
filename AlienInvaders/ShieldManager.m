//
//  AllShields.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/24/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "ShieldManager.h"

#define MAX_SHIELD_LEVEL 5

@interface ShieldManager ()

@property (nonatomic) NSUInteger currentShieldLevel;

@end

@implementation ShieldManager

static ShieldManager *_allShieldsSingleton = nil;


- (id) init {
    self = [super init];
    if (self != nil) {
        _shieldLevel = 0;
        [self restoreShieldLevel];
    }
    
    return self;
}


// ----------------------------------------------------------------------------------------------------
// Singleton
// ----------------------------------------------------------------------------------------------------
+(ShieldManager *)sharedShieldManager
{
    if (!_allShieldsSingleton) {
        _allShieldsSingleton = [[ShieldManager alloc] init];
    }
    return _allShieldsSingleton;
}


// ----------------------------------------------------------------------------------------------------
// Returns the current time the shield lasts after activation
// ----------------------------------------------------------------------------------------------------
- (NSUInteger) shieldTime
{
    NSDictionary *tempDict = [self getShieldDetails:_currentShieldLevel];
    NSUInteger time = [[tempDict objectForKey:@"time"] integerValue];
    return time;
}


// ----------------------------------------------------------------------------------------------------
// Returns the regeneration time the shield needs after having been used
// ----------------------------------------------------------------------------------------------------
- (NSUInteger) shieldRegenerationTime
{
    NSDictionary *tempDict = [self getShieldDetails:_currentShieldLevel];
    NSUInteger reg = [[tempDict objectForKey:@"regeneration"] integerValue];
    return reg;
}


// ----------------------------------------------------------------------------------------------------
// Upgrades the shield level
// ----------------------------------------------------------------------------------------------------
- (void) updateShieldLevel
{
    _currentShieldLevel = MIN(_currentShieldLevel+1, MAX_SHIELD_LEVEL);
    [self saveShieldLevel];
}


// ----------------------------------------------------------------------------------------------------
// Returns whether the shield level can still be upgraded or not
// ----------------------------------------------------------------------------------------------------
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
- (NSDictionary*) getShieldDetails:(NSUInteger)shield
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
// Restoring the shield level from NSUserdefaults
//----------------------------------------------------------
- (void)restoreShieldLevel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger shieldLevel = [[defaults objectForKey:@"shieldLevel"] integerValue];
    _currentShieldLevel = shieldLevel;
}

//----------------------------------------------------------
// Saving the shield level to NSUserdefaults
//----------------------------------------------------------
- (void)saveShieldLevel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInteger:_currentShieldLevel] forKey:@"shieldLevel"];
    [defaults synchronize];
}

@end
