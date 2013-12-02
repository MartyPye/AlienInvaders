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

@property (nonatomic) NSMutableArray *purchasedWeapons;
@property (nonatomic) NSMutableArray *lockedWeapons;

@end

@implementation WeaponManager

static WeaponManager *_allWeaponsSingleton = nil;

- (id) init;
{
    self = [super init];
    if (self != nil){
        
        // default weapons
        self.purchasedWeapons = [NSMutableArray arrayWithArray:@[@"Single Shot",@"Laser",@""]];
        self.lockedWeapons    = [NSMutableArray arrayWithArray:@[@"Double Shot",@"Shotgun",@"Atom Bomb"]];

        
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
- (NSMutableArray*) allPurchasedWeapons
{
    return self.purchasedWeapons;
}


// ----------------------------------------------------------------------------------------------------
// Returns the locked weapons array
// ----------------------------------------------------------------------------------------------------
- (NSMutableArray*) allLockedWeapons
{
    return self.lockedWeapons;
}


//----------------------------------------------------------
// Restoring all the weapons from NSUserdefaults
//----------------------------------------------------------
- (NSMutableArray*)getWeaponArrayForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
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

- (NSUInteger) amountOfPurchasedWeapons;
{
    NSUInteger count = 0;
    for (id obj in self.purchasedWeapons) {
        if (![obj isEqualToString:@""])
            count++;
    }
    return count;
}

- (void) unlockWeapon:(NSString*)weaponName;
{
    // remove weapon from locked weapons
    for (int i = 0; i < self.lockedWeapons.count; i++) {
        if ([[self.lockedWeapons objectAtIndex:i] isEqualToString:weaponName]) {
            [self.lockedWeapons removeObjectAtIndex:i];
        }
    }
    
    // add to purchased weapons
    BOOL foundEmptySpot = NO;
    for (int i = 0; i < self.purchasedWeapons.count; i++) {
        if ([[self.purchasedWeapons objectAtIndex:i] isEqualToString:@""]) {
            [self.purchasedWeapons removeObjectAtIndex:i];
            [self.purchasedWeapons insertObject:weaponName atIndex:i];
            foundEmptySpot = YES;
            break;
        }
    }
    
    if (!foundEmptySpot) {
        [self.purchasedWeapons addObject:weaponName]; 
    }
}

@end
