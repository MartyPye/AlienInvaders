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
    
    return self;
}

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

@end
