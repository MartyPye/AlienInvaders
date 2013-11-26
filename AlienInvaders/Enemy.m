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

- (void) moveEnemy
{
    [self runAction:[SKAction moveToX:-50 duration:self.movingDuration] completion:^{
        [self removeFromParent];
    }];
}

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


- (void) enemyGotHit
{
    NSLog(@"TODO: Do a nice explosion");
}


@end
