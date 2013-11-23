//
//  AllWeapons.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/23/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllWeapons : NSObject

- (NSArray*) getAllPurchasedWeapons;
- (NSArray*) getAllLockedWeapons;

+(AllWeapons *)allWeaponsSingleton;

@end
