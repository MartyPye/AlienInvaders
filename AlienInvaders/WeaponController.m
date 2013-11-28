//
//  WeaponController.m
//  AlienInvaders
//
//  Created by Marty Pye on 28/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "WeaponController.h"
#import "WeaponManager.h"

@implementation WeaponController

- (void) chooseWeapon:(MothershipWeapon*)theWeapon;
{
    NSString* weaponName = theWeapon.name;
    NSArray *purchasedWeapons = [[WeaponManager sharedWeaponManager] allPurchasedWeapons];
//    BOOL weaponHasBeenPurchased = NO;
    for (NSString* obj in purchasedWeapons) {
        if ([obj isEqualToString:weaponName]) {
            _currentWeapon = theWeapon;
//            weaponHasBeenPurchased = YES;
        }
    }
}

@end
