//
//  LevelManager.h
//  AlienInvaders
//
//  Created by Marty Pye on 22/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"

@interface LevelManager : NSObject

+ (LevelManager*) sharedLevelManager;
- (NSUInteger) totalAmountOfLevels;

@end
