//
//  WeaponController.h
//  AlienInvaders
//
//  Created by Marty Pye on 28/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MothershipWeapon.h"

@interface WeaponController : NSObject

@property (nonatomic) MothershipWeapon *currentWeapon;

- (void) chooseWeapon:(MothershipWeapon*)theWeapon;

@end
