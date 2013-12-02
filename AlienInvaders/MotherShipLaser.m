//
//  MotherShipLaser.m
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "MotherShipLaser.h"

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
    Laser *laser = [[Laser alloc] init];
    [laser setPosition:CGPointMake(320, 0)];
    [laser addBodyToLaser];
    [laser addLaserToShip:self.currentMothership withDuration:1.0];
}

@end
