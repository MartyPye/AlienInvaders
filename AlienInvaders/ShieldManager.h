//
//  AllShields.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/24/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShieldManager : NSObject

@property(nonatomic, readonly) NSUInteger shieldLevel;
@property(nonatomic, readonly) NSUInteger shieldTime;
@property(nonatomic, readonly) NSUInteger shieldRegenerationTime;

- (void) updateShieldLevel;
- (BOOL) shieldLevelCanBeUpdated;

+(ShieldManager *)sharedShieldManager;

@end
