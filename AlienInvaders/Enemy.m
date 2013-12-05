//
//  Enemy.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy


// initialize the position of the enemy behind the right edge and give him a certain speed
- (id)initWithYPos:(int)pos AndDuration:(float)duration
{    
    return self;
}


// ----------------------------------------------------------------------------------------------------
// Move enemy from right to left
// ----------------------------------------------------------------------------------------------------
- (void) moveEnemy
{
    [self runAction:[SKAction moveToX:-50 duration:self.movingDuration] completion:^{
        [self removeFromParent];
    }];
}


// ----------------------------------------------------------------------------------------------------
// Adding a body to an enemy
// ----------------------------------------------------------------------------------------------------
- (void) addBodyToEnemy
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cEnemy];
    self.physicsBody.contactTestBitMask =    [Categories getCategoryBitMask:cShip] |
                                                    [Categories getCategoryBitMask:cShipProjectile];
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

// ----------------------------------------------------------------------------------------------------
// Removing the body from an enemy
// ----------------------------------------------------------------------------------------------------
- (void) removeBodyFromEnemy
{
    self.physicsBody = nil;
}

// ----------------------------------------------------------------------------------------------------
// When the enemy is getting hit by the Ship, we don't want it to transform into a coin
// ----------------------------------------------------------------------------------------------------
- (void) enemyGotHitByShip
{
    [self removeAllChildren];
    
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    SKEmitterNode *smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = CGPointMake(0, 0);
    
    [self addChild:smokeTrail];
    
    SKAction *fadeout = [SKAction fadeOutWithDuration:0.25];
    SKAction *waiting = [SKAction waitForDuration:2.0];
    
    SKAction *sequence = [SKAction sequence:@[fadeout,waiting]];
    [self runAction:sequence completion:^{
        [self removeFromParent];
    }];
    
    [_shootingTimer invalidate];
    _shootingTimer = nil;
    
}


// ----------------------------------------------------------------------------------------------------
// When the enemy is getting hit by a prjectile, we want it to transform into a coin
// ----------------------------------------------------------------------------------------------------
- (void) enemyGotHitByWeapon
{
    [self removeAllChildren];
    
    //Place a coin at the position where the enemy got hit
    Coin *coin = [[Coin alloc] initWithPos:self.position];
    [self.scene addChild:coin];
    
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    SKEmitterNode *smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = CGPointMake(0, 0);
    
    [self addChild:smokeTrail];
    
    SKAction *fadeout = [SKAction fadeOutWithDuration:0.25];
    SKAction *waiting = [SKAction waitForDuration:2.0];
    
    SKAction *sequence = [SKAction sequence:@[fadeout,waiting]];
    [self runAction:sequence completion:^{
        [self removeFromParent];
    }];
    
    [_shootingTimer invalidate];
    _shootingTimer = nil;
    
}


@end
