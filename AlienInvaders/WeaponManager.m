//
//  AllWeapons.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/23/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "WeaponManager.h"

#define dummyPurchased @[]

@interface WeaponManager ()

@property (nonatomic) NSArray *purchasedWeapons;
@property (nonatomic) NSArray *lockedWeapons;

@end

@implementation WeaponManager

static WeaponManager *_allWeaponsSingleton = nil;

- (id) init;
{
    self = [super init];
    if (self != nil){
        
        // default weapons
        self.purchasedWeapons = @[@"Single Shot",@"Laser",@""];
        self.lockedWeapons    = @[@"Double Shot",@"Shotgun",@"Atom Bomb"];

        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"purchased"] != nil) {
            self.purchasedWeapons = [self getWeaponArrayForKey:@"purchased"];
            self.lockedWeapons    = [self getWeaponArrayForKey:@"locked"];
        }
    }
    
    return self;
}


// ----------------------------------------------------------------------------------------------------
// Singleton
// ----------------------------------------------------------------------------------------------------
+(WeaponManager *)sharedWeaponManager
{
    if (!_allWeaponsSingleton) {
        _allWeaponsSingleton = [[WeaponManager alloc] init];
    }
    return _allWeaponsSingleton;
}


// ----------------------------------------------------------------------------------------------------
// Returns the purchased weapon array
// ----------------------------------------------------------------------------------------------------
- (NSArray*) allPurchasedWeapons
{
    return self.purchasedWeapons;
}


// ----------------------------------------------------------------------------------------------------
// Returns the locked weapons array
// ----------------------------------------------------------------------------------------------------
- (NSArray*) allLockedWeapons
{
    return self.lockedWeapons;
}


//----------------------------------------------------------
// Restoring all the weapons from NSUserdefaults
//----------------------------------------------------------
- (NSArray*)getWeaponArrayForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

//----------------------------------------------------------
// Saving all the weapons to NSUserdefaults
//----------------------------------------------------------
- (void)saveWeaponArrays
{
    NSData *purchasedWeaponsArchived = [NSKeyedArchiver archivedDataWithRootObject:_purchasedWeapons];
    NSData *lockedWeaponsArchived = [NSKeyedArchiver archivedDataWithRootObject:_lockedWeapons];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:purchasedWeaponsArchived forKey:@"purchased"];
    [defaults setObject:lockedWeaponsArchived forKey:@"locked"];
    [defaults synchronize];
}

@end
