//
//  CoinManager.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/28/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "CoinManager.h"

@implementation CoinManager

static CoinManager *_coinManagerSingleton = nil;


// ----------------------------------------------------------------------------------------------------
// Singleton
// ----------------------------------------------------------------------------------------------------
+(CoinManager *)sharedCoinManager
{
    if (!_coinManagerSingleton) {
        _coinManagerSingleton = [[CoinManager alloc] init];
    }
    return _coinManagerSingleton;
}

- (void) initCoinsCollectedInCurrentLevel
{
    _coinsCollectedInCurrentLevel = 0;
}

- (void) increaseCoinsCollectedInCurrentLevelBy:(int)amount
{
    [self setCoinsCollectedInCurrentLevel:_coinsCollectedInCurrentLevel + amount];
}



@end
