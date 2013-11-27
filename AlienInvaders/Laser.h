//
//  Laser.h
//  AlienInvaders
//
//  Created by Claude Bemtgen on 11/27/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Categories.h"

@interface Laser : SKSpriteNode

- (void) addBodyToLaser;

- (void) addLaserToShip:(SKSpriteNode*)ship withDuration:(float)duration;


@end
