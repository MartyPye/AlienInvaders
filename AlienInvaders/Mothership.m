//
//  Mothership.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/26/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "Mothership.h"

@implementation Mothership

- (id) initWithLife:(float)life
{
    self = [super initWithImageNamed:@"MotherShip"];

    _wholeLife = life;
    _lifeLeft = life;
    
    self.position = CGPointMake(50, 160);
    self.zPosition = 10;
    
    [self addBodyToMothership];
    [self addBurst];
    
    return self;
}

// This methond is getting called when the user moves the ship with his finger
// We do not want the ship to be higher than 280, because in that area we have our health bar an other stuff
// TODO: Limit the position on the bottom?
- (void) moveToY:(int)yCoord
{
    int y;
    y = yCoord;
    
    if (yCoord > 280){
        y=280;
    }
    
    [self setPosition:CGPointMake(self.position.x, y)];
}


- (void) addBodyToMothership
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = [Categories getCategoryBitMask:cShip];
    self.physicsBody.contactTestBitMask =    [Categories getCategoryBitMask:cEnemy] |
                                                    [Categories getCategoryBitMask:cEnemyProjectile] |
                                                    [Categories getCategoryBitMask:cMeteor];
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}


- (void) addBurst
{
    //adding the smokeTrail
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"mothershipBurst" ofType:@"sks"];
    SKEmitterNode *smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = CGPointMake(-20, 0);
    [self addChild:smokeTrail];
}

@end
