//
//  AllWeapons.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/23/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "AllWeapons.h"

#define dummyPurchased @[]

@interface AllWeapons ()

@property (nonatomic) NSArray *purchasedWeapons;
@property (nonatomic) NSArray *lockedWeapons;

@end

@implementation AllWeapons

static AllWeapons *_allWeaponsSingleton = nil;

+(AllWeapons *)allWeaponsSingleton
{
    if (!_allWeaponsSingleton) {
        _allWeaponsSingleton = [[AllWeapons alloc] init];
    }
    return _allWeaponsSingleton;
}

- (NSArray*) getAllPurchasedWeapons
{
    NSArray *returnArray = [self getWeaponArrayForKey:@"purchased"];
    if (returnArray == nil) {
        returnArray = @[@"Single Shot"];
    }
    
    return returnArray;
}


- (NSArray*) getAllLockedWeapons
{
    NSArray *returnArray = [self getWeaponArrayForKey:@"locked"];
    if (returnArray == nil) {
        returnArray = @[@"Double Shot",@"Shotgun",@"Laser",@"Grenade Shooter"];
    }
    
    return returnArray;
}


//----------------------------------------------------------
// Restoring the highscore manager from NSUserdefaults
//----------------------------------------------------------
- (NSArray*)getWeaponArrayForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

//----------------------------------------------------------
// Saving the highscore manager to NSUserdefaults
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
