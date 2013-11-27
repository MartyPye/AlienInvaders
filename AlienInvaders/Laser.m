//
//  Laser.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Laser.h"

@implementation Laser

- (id) init {
    self = [super initWithImageNamed:@"laserbeam"];
    
    return self;
}

- (void) addBodyToLaser
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cShipProjectile];
    self.physicsBody.contactTestBitMask =       [Categories getCategoryBitMask:cEnemy] |
                                                [Categories getCategoryBitMask:cEnemyProjectile];
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

- (void) addLaserToShip:(SKSpriteNode*)ship withDuration:(float)duration
{
    [ship addChild:self];
    
    SKAction *fadein = [SKAction fadeInWithDuration:0.25];
    SKAction *waiting = [SKAction waitForDuration:duration-1];
    SKAction *fadeout = [SKAction fadeOutWithDuration:0.25];
    
    SKAction *sequence = [SKAction sequence:@[fadein,waiting,fadeout]];
    [self runAction:sequence completion:^{
        [self removeFromParent];
    }];
}


- (void) bulletHitSomething
{
    // Don't do anything here
}

@end
