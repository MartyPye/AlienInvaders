//
//  Coin.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/28/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Categories.h"
#import "CoinManager.h"

@interface Coin : SKSpriteNode

- (id)initWithPos:(CGPoint)pos;
- (void) collectedTheCoin;

@end
