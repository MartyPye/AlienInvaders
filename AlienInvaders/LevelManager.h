//
//  LevelManager.h
//  AlienInvaders
//
//  Created by Marty Pye on 22/11/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "CoinManager.h"

@interface LevelManager : NSObject

// this is set when the user select a level in the Level Selection View
@property (nonatomic) NSUInteger currentLevelIndex;
@property (nonatomic) SKScene *scene;
@property (nonatomic) NSMutableDictionary *pointsCollectedInLevel;
@property (nonatomic) NSMutableDictionary *pointsToStarsDict;

+ (LevelManager*) sharedLevelManager;
- (NSUInteger) totalAmountOfLevels;
- (void) realizedNumberOfPoints:(int)points;
- (void) setupCurrentLevel;
- (void) pauseLevel;
- (void) finishLevel;

@end
