//
//  Bullet.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

- (id)initWithPosition:(CGPoint)pos
{
    self = [super initWithImageNamed:@"Bullet"];
    self.position = CGPointMake(pos.x+20, pos.y);
    
    [self addBodyToBullet];
 
    return self;
}

- (void) moveToPosition:(CGPoint)newPos
{
    [self runAction:[SKAction moveToX:600 duration:5.0] completion:^{
        [self removeFromParent];
    }];
}

- (void) addBodyToBullet
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cShipProjectile];
    self.physicsBody.contactTestBitMask =       [Categories getCategoryBitMask:cEnemy] |
                                                [Categories getCategoryBitMask:cEnemyProjectile] |
                                                [Categories getCategoryBitMask:cMeteor];
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}


- (void) bulletHitSomething
{
    [self removeFromParent];
}

@end
