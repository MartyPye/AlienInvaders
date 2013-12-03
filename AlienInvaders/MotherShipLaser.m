//
//  MotherShipLaser.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "MotherShipLaser.h"

#define LASERTIME 2.0

@implementation MotherShipLaser

- (id) initWithScene:(SKScene*)scene
{
    self = [super init];
    self.scene = scene;
    self.name = @"Laser";
    
    return self;
}

- (void) fireFromPosition:(CGPoint)pos
{
    /*
    Laser *laser = [[Laser alloc] init];
    [laser setPosition:CGPointMake(320, 0)];
    [laser addBodyToLaser];
    [laser addLaserToShip:self.currentMothership withDuration:5.0];
     */
    
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"laser" ofType:@"sks"];
    SKEmitterNode *smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = CGPointMake(15, 0);
    
    smokeTrail.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(600, 2)];
    smokeTrail.physicsBody.dynamic = YES;
    smokeTrail.physicsBody.contactTestBitMask =       [Categories getCategoryBitMask:cEnemy] |
    [Categories getCategoryBitMask:cEnemyProjectile];
    smokeTrail.physicsBody.collisionBitMask = 0;
    smokeTrail.physicsBody.usesPreciseCollisionDetection = YES;
    
    [self.currentMothership addChild:smokeTrail];
    [self performSelector:@selector(removeLaser) withObject:Nil afterDelay:LASERTIME];
}

- (void) removeLaser {
    [self.currentMothership removeAllChildren];
    [self.currentMothership addBurst];
}

@end
