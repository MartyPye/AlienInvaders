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


// ----------------------------------------------------------------------------------------------------
// (Re)initializes the amount of coins collected in the current level
// ----------------------------------------------------------------------------------------------------
- (void) initCoinsCollectedInCurrentLevel
{
    _coinsCollectedInCurrentLevel = 0;
}

// ----------------------------------------------------------------------------------------------------
// Increases the amount of coins collected in the current level
// ----------------------------------------------------------------------------------------------------
- (void) increaseCoinsCollectedInCurrentLevelBy:(int)amount
{
    [self setCoinsCollectedInCurrentLevel:_coinsCollectedInCurrentLevel + amount];
}


// ----------------------------------------------------------------------------------------------------
// Increases the amount of coins that can be spent
// ----------------------------------------------------------------------------------------------------
- (void) addCoinsThatCanBeSpent:(int)amount
{
    _coinsToSpendInTheUpgradStore = _coinsToSpendInTheUpgradStore + amount;
    [self saveCoinsThatCanBeSpent];
}


// ----------------------------------------------------------------------------------------------------
// Reduce the amount of coins that can be spent
// ----------------------------------------------------------------------------------------------------
- (void) removeCoinsThatCanBeSpent:(int)amount
{
    _coinsToSpendInTheUpgradStore = _coinsToSpendInTheUpgradStore - amount;
    [self saveCoinsThatCanBeSpent];
}


//----------------------------------------------------------
// Restoring the _pointsCollectedInLevel from NSUserdefaults
//----------------------------------------------------------
- (void)restoreCoinsThatCanBeSpent
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *coins = [defaults objectForKey:@"coinsToSpent"];
    if (coins != nil) {
        _coinsToSpendInTheUpgradStore = [coins intValue];
    } else {
        _coinsToSpendInTheUpgradStore = 0;
    }
}

//----------------------------------------------------------
// Saving the _pointsCollectedInLevel to NSUserdefaults
//----------------------------------------------------------
- (void)saveCoinsThatCanBeSpent
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:_coinsToSpendInTheUpgradStore] forKey:@"coinsToSpent"];
    [defaults synchronize];
}


@end
