//
//  CoinManager.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/28/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoinManager : NSObject

@property (nonatomic, assign) int coinsCollectedInCurrentLevel;

- (void) initCoinsCollectedInCurrentLevel;
- (void) increaseCoinsCollectedInCurrentLevelBy:(int)amount;

+(CoinManager *)sharedCoinManager;

@end
