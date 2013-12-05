//
//  StandardEnemy.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "StandardEnemy.h"

@implementation StandardEnemy


- (id)initWithYPos:(int)pos AndDuration:(float)duration
{
    self = [super initWithImageNamed:@"standardEnemy"];
    
    self.position = CGPointMake(600, pos);
//    self.size = CGSizeMake(25, 22);

    self.movingDuration = duration;
    [self addBodyToEnemy];
    
    [self addBurst];
    
    [self initShootingTimer];
        
    return self;
}

// ----------------------------------------------------------------------------------------------------
// Adding the burst behind our enemy
// ----------------------------------------------------------------------------------------------------
- (void) addBurst
{
    //adding the smokeTrail
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"enemyBurst" ofType:@"sks"];
    SKEmitterNode *smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = CGPointMake(13, 0);
    [self addChild:smokeTrail];
}



// ----------------------------------------------------------------------------------------------------
// Shooting
// ----------------------------------------------------------------------------------------------------
- (void) initShootingTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1+arc4random()%3
                                                      target:self
                                                    selector:@selector(shoot)
                                                    userInfo:nil
                                                     repeats:YES];
    self.shootingTimer = timer;
}

- (void) shoot
{
    SKSpriteNode *enemyProjectile = [[SKSpriteNode alloc] initWithImageNamed:@"enemyBullet"];
    [enemyProjectile setPosition:self.position];
    [self.scene addChild:enemyProjectile];
    [enemyProjectile runAction:[SKAction moveByX:-1000 y:-100+arc4random()%200 duration:5] completion:^{
        [enemyProjectile removeFromParent];
    }];
    [self addBodyToProjectile:enemyProjectile];
}

// ----------------------------------------------------------------------------------------------------
// Adding a body to a projectile
// ----------------------------------------------------------------------------------------------------
- (void) addBodyToProjectile:(SKSpriteNode*)projectile
{
    projectile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(projectile.size.width, projectile.size.height)];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cEnemyProjectile];
    projectile.physicsBody.contactTestBitMask =    [Categories getCategoryBitMask:cShip];/* | [Categories getCategoryBitMask:cShipProjectile];*/
    projectile.physicsBody.collisionBitMask = 0;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
}


@end
