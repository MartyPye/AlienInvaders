//
//  Enemy.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Categories.h"

@interface Enemy : SKSpriteNode

@property (nonatomic, assign) CGPoint startPosition;
@property (nonatomic, assign) int movingDuration;

- (id)initWithYPos:(int)pos AndDuration:(float)duration;
- (void) moveEnemy;
- (void) addBodyToEnemy;
- (void) enemyGotHit;

@end
