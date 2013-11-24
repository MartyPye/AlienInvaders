//
//  AllShields.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/24/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllShields : NSObject

- (int) getCurrentShieldLevel;
- (int) getShieldTime;
- (int) getShieldRecuperation;

- (void) updateShieldLevel;
- (BOOL) shieldLevelCanBeUpdated;

+(AllShields *)allShieldsSingleton;

@end
