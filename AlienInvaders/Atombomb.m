//
//  Atombomb.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Atombomb.h"

@implementation Atombomb

- (id)initWithPosition:(CGPoint)pos
{
    self = [super initWithImageNamed:@"Bullet"];
    self.position = CGPointMake(pos.x+20, pos.y);
    
    [self addBodyToBullet];
    
    return self;
}

- (void) moveToPosition:(CGPoint)newPos withDuration:(float)duration
{
    [self runAction:[SKAction moveTo:newPos duration:duration] completion:^{
        [self removeFromParent];
    }];
}

- (void) addBodyToBullet
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cShipProjectile];
    self.physicsBody.contactTestBitMask =       [Categories getCategoryBitMask:cEnemy] |
                                                [Categories getCategoryBitMask:cEnemyProjectile];
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}


- (void) bulletHitSomething
{
    [self removeAllActions];
    
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"atomExplosion" ofType:@"sks"];
    SKEmitterNode *smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = CGPointMake(0, 0);
    [self addChild:smokeTrail];
    
    //TODO: make the physicsbody bigger and remove it afterwards
}

@end
