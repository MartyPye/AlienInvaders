//
//  AllWeapons.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/23/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeaponManager : NSObject

- (NSMutableArray*) allPurchasedWeapons;
- (NSMutableArray*) allLockedWeapons;

+(WeaponManager *)sharedWeaponManager;
- (NSUInteger) amountOfPurchasedWeapons;
- (void) unlockWeapon:(NSString*)weaponName;
- (void)saveWeaponArrays;

@end
